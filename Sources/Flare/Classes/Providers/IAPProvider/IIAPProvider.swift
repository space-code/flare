//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

/// Type that provides in-app purchase functionality.
public protocol IIAPProvider {
    /// False if this device is not able or allowed to make payments
    var canMakePayments: Bool { get }

    /// Retrieves localized information from the App Store about a specified list of products.
    ///
    /// - Parameters:
    ///   - productIDs: The list of product identifiers for which you wish to retrieve descriptions.
    ///   - completion: The completion containing the response of retrieving products.
    func fetch(productIDs: Set<String>, completion: @escaping Closure<Result<[StoreProduct], IAPError>>)

    /// Retrieves localized information from the App Store about a specified list of products.
    ///
    /// - Parameter productIDs: The list of product identifiers for which you wish to retrieve descriptions.
    ///
    /// - Throws: `IAPError(error:)` if the request did fail with error.
    ///
    /// - Returns: An array of products.
    func fetch(productIDs: Set<String>) async throws -> [StoreProduct]

    /// Performs a purchase of a product with a given ID.
    ///
    /// - Note: The method automatically checks if the user can purchase a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameters:
    ///   - productID: The product identifier.
    ///   - completion: The closure to be executed once the purchase is complete.
    func purchase(productID: String, completion: @escaping Closure<Result<PaymentTransaction, IAPError>>)

    /// Purchases a product with a given ID.
    ///
    /// - Note: The method automatically checks if the user can purchase a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameter productID: The product identifier.
    ///
    /// - Throws: `IAPError.paymentNotAllowed` if user can't make payment.
    ///
    /// - Returns: A payment transaction.
    func purchase(productID: String) async throws -> PaymentTransaction

    /// Refreshes the receipt, representing the user's transactions with your app.
    ///
    /// - Parameter completion: The closure to be executed when the refresh operation ends.
    func refreshReceipt(completion: @escaping Closure<Result<String, IAPError>>)

    /// Refreshes the receipt, representing the user's transactions with your app.
    ///
    /// `IAPError(error:)` if the request did fail with error.
    ///
    /// - Returns: A receipt.
    func refreshReceipt() async throws -> String

    /// Removes a finished (i.e. failed or completed) transaction from the queue.
    /// Attempting to finish a purchasing transaction will throw an exception.
    ///
    /// - Parameter transaction: An object in the payment queue.
    func finish(transaction: PaymentTransaction)

    /// Adds transaction observer to the payment queue.
    /// The transactions array will only be synchronized with the server while the queue has observers.
    ///
    /// - Note: This may require that the user authenticate.
    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?)

    /// Removes transaction observer from the payment queue.
    /// The transactions array will only be synchronized with the server while the queue has observers.
    ///
    /// - Note: This may require that the user authenticate.
    func removeTransactionObserver()

    #if os(iOS) || VISION_OS
        /// Present the refund request sheet for the specified transaction in a window scene.
        ///
        /// - Parameter productID: The identifier of the transaction the user is requesting a refund for.
        ///
        /// - Returns: The result of the refund request.
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func beginRefundRequest(productID: String) async throws -> RefundRequestStatus
    #endif
}
