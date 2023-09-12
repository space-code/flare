//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import protocol StoreKit.SKRequestDelegate

/// A type that is responsible for create a receipt request.
protocol IReceiptRefreshRequestFactory {
    /// Makes a new instance of `IReceiptRefreshRequest`.
    ///
    /// - Parameters:
    ///   - id: The request's identifier.
    ///   - delegate: The request's delegate.
    ///
    /// - Returns: A request.
    func make(id: String, delegate: SKRequestDelegate?) -> IReceiptRefreshRequest
}
