//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

public protocol IFlare {
    /// Retrieve localized information from the App Store about a specified list of products.
    ///
    /// - Parameters:
    ///   - ids: The list of product identifiers for the products you wish to retrieve descriptions of.
    ///   - completion: A products handler.
    func fetch(ids: Set<String>, completion: @escaping Closure<Result<[SKProduct], IAPError>>)

    /// Retrieve localized information from the App Store about a specified list of products.
    ///
    /// - Parameter ids: The list of product identifiers for the products you wish to retrieve descriptions of.
    ///
    /// - Returns: Products.
    func fetch(ids: Set<String>) async throws -> [SKProduct]

    /// Perform purchase a product with given id.
    ///
    /// - Parameters:
    ///   - id: A product identifier.
    ///   - completion: A block object to be executed when the purchase operation ends.
    func buy(id: String, completion: @escaping Closure<Result<PaymentTransaction, IAPError>>)

    /// Perform purchase a product with given id.
    ///
    /// - Parameter id: A product identifier.
    ///
    /// - Returns: A payment transaction.
    func buy(id: String) async throws -> PaymentTransaction

    /// A request to refresh the receipt, which represents the user’s transactions with your app.
    ///
    /// - Parameter completion: A block object to be executed when the refresh operation ends.
    func receipt(completion: @escaping Closure<Result<String, IAPError>>)

    /// A request to refresh the receipt, which represents the user’s transactions with your app.
    ///
    /// - Returns: A receipt.
    func receipt() async throws -> String

    /// Remove a finished (i.e. failed or completed) transaction from the queue.
    /// Attempting to finish a purchasing transaction will throw an exception.
    ///
    /// - Parameter transaction: An object in the payment queue.
    func finish(transaction: PaymentTransaction)

    /// The transactions array will only be synchronized with the server while the queue has observers.
    /// This may require that the user authenticate
    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?)

    /// The transactions array will only be synchronized with the server while the queue has observers.
    /// This may require that the user authenticate
    func removeTransactionObserver()
}
