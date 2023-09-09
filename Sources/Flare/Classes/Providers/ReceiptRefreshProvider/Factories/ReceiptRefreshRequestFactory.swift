//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import class StoreKit.SKReceiptRefreshRequest
import protocol StoreKit.SKRequestDelegate

// MARK: - IReceiptRefreshRequestFactory

protocol IReceiptRefreshRequestFactory {
    func make(id: String, delegate: SKRequestDelegate?) -> IReceiptRefreshRequest
}

// MARK: - ReceiptRefreshRequestFactory

final class ReceiptRefreshRequestFactory: IReceiptRefreshRequestFactory {
    func make(id: String, delegate: SKRequestDelegate?) -> IReceiptRefreshRequest {
        let request = SKReceiptRefreshRequest()
        request.id = id
        request.delegate = delegate
        return request
    }
}
