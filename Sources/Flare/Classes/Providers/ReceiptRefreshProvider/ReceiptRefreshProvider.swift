//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Concurrency
import Foundation
import StoreKit

// MARK: - ReceiptRefreshProvider

final class ReceiptRefreshProvider: NSObject {
    // MARK: Properties

    private let dispatchQueueFactory: IDispatchQueueFactory
    private let fileManager: IFileManager
    private let appStoreReceiptProvider: IAppStoreReceiptProvider
    private let receiptRefreshRequestFactory: IReceiptRefreshRequestFactory

    private var handlers: [String: ReceiptRefreshHandler] = [:]

    private lazy var dispatchQueue: IDispatchQueue = dispatchQueueFactory.privateQueue(label: String(describing: self))

    // MARK: Initialization

    init(
        dispatchQueueFactory: IDispatchQueueFactory = DispatchQueueFactory(),
        fileManager: IFileManager = FileManager.default,
        appStoreReceiptProvider: IAppStoreReceiptProvider = Bundle.main,
        receiptRefreshRequestFactory: IReceiptRefreshRequestFactory = ReceiptRefreshRequestFactory()
    ) {
        self.dispatchQueueFactory = dispatchQueueFactory
        self.fileManager = fileManager
        self.appStoreReceiptProvider = appStoreReceiptProvider
        self.receiptRefreshRequestFactory = receiptRefreshRequestFactory
    }

    // MARK: Internal

    var receipt: String? {
        if let appStoreReceiptURL = appStoreReceiptProvider.appStoreReceiptURL,
           fileManager.fileExists(atPath: appStoreReceiptURL.path)
        {
            let receiptData = try? Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
            let receiptString = receiptData?.base64EncodedString(options: [])
            return receiptString
        }
        return nil
    }

    // MARK: Private

    private func makeRequest(id: String) -> IReceiptRefreshRequest {
        receiptRefreshRequestFactory.make(id: id, delegate: self)
    }

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
    func refresh(requestId: String, handler: @escaping ReceiptRefreshHandler) {
        let request = makeRequest(id: requestId)
        fetch(request: request, handler: handler)
    }

    func refresh(requestId: String) async throws {
        try await withCheckedThrowingContinuation { continuation in
            refresh(requestId: requestId) { result in
                switch result {
                case .success:
                    continuation.resume(with: .success(()))
                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

// MARK: SKRequestDelegate

extension ReceiptRefreshProvider: SKRequestDelegate {
    func request(_ request: SKRequest, didFailWithError error: Error) {
        dispatchQueue.async {
            let handler = self.handlers.removeValue(forKey: request.id)
            self.dispatchQueueFactory.main().async {
                handler?(.failure(IAPError(error: error)))
            }
        }
    }

    func requestDidFinish(_ request: SKRequest) {
        dispatchQueue.async {
            let handler = self.handlers.removeValue(forKey: request.id)
            self.dispatchQueueFactory.main().async {
                handler?(.success(()))
            }
        }
    }
}
