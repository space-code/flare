//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

public protocol IReceiptRefreshProvider {
    /// The bundle’s App Store receipt.
    var receipt: String? { get }

    /// A request to refresh the receipt, which represents the user’s transactions with your app.
    ///
    /// - Parameters:
    ///   - requestId: A request identifier.
    ///   - handler: A receipt refresh handler.
    func refresh(requestId: String, handler: @escaping ReceiptRefreshHandler)

    /// A request to refresh the receipt, which represents the user’s transactions with your app.
    ///
    /// - Parameter requestId: A request identifier.
    func refresh(requestId: String) async throws
}
