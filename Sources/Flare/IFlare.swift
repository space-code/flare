//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

/// `Flare` creates and manages in-app purchases.
public protocol IFlare {
    /// Retrieves localized information from the App Store about a specified list of products.
    ///
    /// - Parameters:
    ///   - ids: The list of product identifiers for which you wish to retrieve descriptions.
    ///   - completion: The completion containing the response of retrieving products.
    func fetch(ids: Set<String>, completion: @escaping Closure<Result<[SKProduct], IAPError>>)

    /// Retrieves localized information from the App Store about a specified list of products.
    ///
    /// - Parameter ids: The list of product identifiers for which you wish to retrieve descriptions.
    ///
    /// - Throws: `IAPError(error:)` if the request did fail with error.
    ///
    /// - Returns: An array of products.
    func fetch(ids: Set<String>) async throws -> [SKProduct]

    /// Performs a purchase of a product with a given ID.
    ///
    /// - Note: The method automatically checks if the user can buy a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameters:
    ///   - id: The product identifier.
    ///   - completion: The closure to be executed once the purchase is complete.
    func buy(id: String, completion: @escaping Closure<Result<PaymentTransaction, IAPError>>)

    /// Purchases a product with a given ID.
    ///
    /// - Note: The method automatically checks if the user can buy a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameter id: The product identifier.
    ///
    /// - Throws: `IAPError.paymentNotAllowed` if user can't make payment.
    ///
    /// - Returns: A payment transaction.
    func buy(id: String) async throws -> PaymentTransaction

    /// Refreshes the receipt, representing the user's transactions with your app.
    ///
    /// - Parameter completion: The closure to be executed when the refresh operation ends.
    func receipt(completion: @escaping Closure<Result<String, IAPError>>)

    /// Refreshes the receipt, representing the user's transactions with your app.
    ///
    /// `IAPError(error:)` if the request did fail with error.
    ///
    /// - Returns: A receipt.
    func receipt() async throws -> String

    /// Removes a finished (i.e. failed or completed) transaction from the queue.
    /// Attempting to finish a purchasing transaction will throw an exception.
    ///
    /// - Parameter transaction: An object in the payment queue.
    func finish(transaction: PaymentTransaction)

    /// The transactions array will only be synchronized with the server while the queue has observers.
    ///
    /// - Note: This may require that the user authenticate.
    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?)

    /// The transactions array will only be synchronized with the server while the queue has observers.
    ///
    /// - Note: This may require that the user authenticate.
    func removeTransactionObserver()
}
