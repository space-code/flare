//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import class StoreKit.SKReceiptRefreshRequest
import protocol StoreKit.SKRequestDelegate

final class ReceiptRefreshRequestFactory: IReceiptRefreshRequestFactory {
    func make(requestID: String, delegate: SKRequestDelegate?) -> IReceiptRefreshRequest {
        let request = SKReceiptRefreshRequest()
        request.id = requestID
        request.delegate = delegate
        return request
    }
}
