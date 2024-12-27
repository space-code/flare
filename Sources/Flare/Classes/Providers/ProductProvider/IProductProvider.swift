//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

typealias PaymentHandler = @Sendable (_ queue: PaymentQueue, _ result: Result<SKPaymentTransaction, IAPError>) -> Void
typealias RestoreHandler = @Sendable (_ queue: SKPaymentQueue, _ error: IAPError?) -> Void
typealias ShouldAddStorePaymentHandler = (_ queue: SKPaymentQueue, _ payment: SKPayment, _ product: SKProduct) -> Bool
typealias ReceiptRefreshHandler = @Sendable (Result<Void, IAPError>) -> Void

// MARK: - IProductProvider

/// A type that is responsible for retrieving StoreKit products.
protocol IProductProvider {
    typealias ProductsHandler = SendableClosure<Result<[StoreProduct], IAPError>>

    /// Retrieves localized information from the App Store about a specified list of products.
    ///
    /// - Parameters:
    ///   - productIDs: The list of product identifiers for which you wish to retrieve descriptions.
    ///   - requestID: The request identifier.
    ///   - completion: The completion containing the response of retrieving products.
    func fetch(productIDs: some Collection<String>, requestID: String, completion: @escaping ProductsHandler)

    /// Retrieves localized information from the App Store about a specified list of products.
    ///
    /// - Note:This method utilizes the new `StoreKit2` API.
    ///
    /// - Parameter productIDs: The list of product identifiers for which you wish to retrieve descriptions.
    ///
    /// - Returns: The requested products.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func fetch(productIDs: some Collection<String>) async throws -> [StoreProduct]
}
