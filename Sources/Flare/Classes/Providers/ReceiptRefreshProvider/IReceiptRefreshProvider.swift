//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

/// A type that can refresh the bundle's App Store receipt.
protocol IReceiptRefreshProvider {
    /// The bundle’s App Store receipt.
    var receipt: String? { get }

    /// Refreshes the receipt, representing the user's transactions with your app.
    ///
    /// - Parameters:
    ///   - requestID: The request identifier.
    ///   - handler: The closure to be executed when the refresh operation ends.
    func refresh(requestID: String, handler: @escaping ReceiptRefreshHandler)

    /// Refreshes the receipt, representing the user's transactions with your app.
    ///
    /// - Parameter requestID: The request identifier.
    ///
    /// - Throws: `IAPError(error:)` if the request did fail with error.
    func refresh(requestID: String) async throws
}
