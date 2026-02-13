//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Concurrency
import Foundation
import StoreKit

// MARK: - ReceiptRefreshProvider

/// A class that can refresh the bundle's App Store receipt.
final class ReceiptRefreshProvider: NSObject, @unchecked Sendable {
    // MARK: Properties

    /// The dispatch queue factory.
    private let dispatchQueueFactory: IDispatchQueueFactory
    /// A convenient interface to the contents of the file system, and the primary means of interacting with it.
    private let fileManager: IFileManager
    /// The type that retrieves the App Store receipt URL.
    private let appStoreReceiptProvider: IAppStoreReceiptProvider
    /// The receipt refresh request factory.
    private let receiptRefreshRequestFactory: IReceiptRefreshRequestFactory

    /// Collection of handlers for receipt refresh requests.
    private var handlers: [String: ReceiptRefreshHandler] = [:]

    /// Lazy-initialized private dispatch queue for handling tasks related to refreshing receipts.
    private lazy var dispatchQueue: IDispatchQueue = dispatchQueueFactory.privateQueue(label: String(describing: self))

    // MARK: Initialization

    /// Creates a new `ReceiptRefreshProvider` instance.
    ///
    /// - Parameters:
    ///   - dispatchQueueFactory: The dispatch queue factory.
    ///   - fileManager: A convenient interface to the contents of the file system, and the primary means of interacting with it.
    ///   - appStoreReceiptProvider: The type that retrieves the App Store receipt URL.
    ///   - receiptRefreshRequestFactory: The receipt refresh request factory.
    init(
        dispatchQueueFactory: IDispatchQueueFactory,
        fileManager: IFileManager = FileManager.default,
        appStoreReceiptProvider: IAppStoreReceiptProvider = Bundle.main,
        receiptRefreshRequestFactory: IReceiptRefreshRequestFactory
    ) {
        self.dispatchQueueFactory = dispatchQueueFactory
        self.fileManager = fileManager
        self.appStoreReceiptProvider = appStoreReceiptProvider
        self.receiptRefreshRequestFactory = receiptRefreshRequestFactory
    }

    // MARK: Internal

    /// Computed property to retrieve the base64-encoded app store receipt string.
    var receipt: String? {
        if let appStoreReceiptURL = appStoreReceiptProvider.appStoreReceiptURL,
           fileManager.fileExists(atPath: appStoreReceiptURL.path)
        {
            let receiptData = try? Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
            return receiptData?.base64EncodedString(options: [])
        }
        return nil
    }

    // MARK: Private

    /// Creates a refresh receipt request.
    ///
    /// - Parameter id: The request identifier.
    ///
    /// - Returns: A receipt refresh request.
    private func makeRequest(id: String) -> IReceiptRefreshRequest {
        receiptRefreshRequestFactory.make(requestID: id, delegate: self)
    }

    /// Fetches receipt information using a refresh request.
    ///
    /// - Parameters:
    ///   - request: The refresh request.
    ///   - handler: The closure to be executed once the refresh is complete.
    private func fetch(request: IReceiptRefreshRequest, handler: @escaping ReceiptRefreshHandler) {
        dispatchQueue.async {
            self.handlers[request.id] = handler

            self.dispatchQueueFactory.main().async {
                request.start()
            }
        }
    }
}

// MARK: IReceiptRefreshProvider

extension ReceiptRefreshProvider: IReceiptRefreshProvider {
    func refresh(requestID: String, handler: @escaping ReceiptRefreshHandler) {
        Logger.info(message: L10n.Receipt.refreshingReceipt(requestID))

        let request = makeRequest(id: requestID)
        fetch(request: request, handler: handler)
    }

    func refresh(requestID: String) async throws {
        try await withCheckedThrowingContinuation { continuation in
            refresh(requestID: requestID) { result in
                continuation.resume(with: result)
            }
        }
    }
}

// MARK: SKRequestDelegate

extension ReceiptRefreshProvider: SKRequestDelegate {
    func request(_ request: SKRequest, didFailWithError error: Error) {
        Logger.error(message: L10n.Receipt.refreshingReceiptFailed(request.id, error.localizedDescription))

        dispatchQueue.async {
            let handler = self.handlers.removeValue(forKey: request.id)
            self.dispatchQueueFactory.main().async {
                handler?(.failure(IAPError(error: error)))
            }
        }
    }

    func requestDidFinish(_ request: SKRequest) {
        Logger.info(message: L10n.Receipt.refreshedReceipt(request.id))

        dispatchQueue.async {
            let handler = self.handlers.removeValue(forKey: request.id)
            self.dispatchQueueFactory.main().async {
                handler?(.success(()))
            }
        }
    }
}
