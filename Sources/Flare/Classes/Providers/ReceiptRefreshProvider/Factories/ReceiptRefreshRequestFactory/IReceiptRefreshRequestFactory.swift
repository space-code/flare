//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import protocol StoreKit.SKRequestDelegate

/// A type that is responsible for create a receipt request.
protocol IReceiptRefreshRequestFactory {
    /// Makes a new instance of `IReceiptRefreshRequest`.
    ///
    /// - Parameters:
    ///   - requestID: The request's identifier.
    ///   - delegate: The request's delegate.
    ///
    /// - Returns: A request.
    func make(requestID: String, delegate: SKRequestDelegate?) -> IReceiptRefreshRequest
}
