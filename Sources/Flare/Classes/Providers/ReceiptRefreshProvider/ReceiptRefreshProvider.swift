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
    private var handlers: [String: ReceiptRefreshHandler] = [:]

    private lazy var dispatchQueue: IDispatchQueue = dispatchQueueFactory.privateQueue(label: String(describing: self))

    // MARK: Initialization

    init(dispatchQueueFactory: IDispatchQueueFactory = DispatchQueueFactory()) {
        self.dispatchQueueFactory = dispatchQueueFactory
    }

    // MARK: Internal

    var receipt: String? {
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
           FileManager.default.fileExists(atPath: appStoreReceiptURL.path)
        {
            let receiptData = try? Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
            let receiptString = receiptData?.base64EncodedString(options: [])
            return receiptString
        }
        return nil
    }

    // MARK: Private

    private func makeRequest(id: String) -> SKReceiptRefreshRequest {
        let request = SKReceiptRefreshRequest()
        request.id = id
        request.delegate = self
        return request
    }

    private func fetch(request: SKRequest, handler: @escaping ReceiptRefreshHandler) {
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
