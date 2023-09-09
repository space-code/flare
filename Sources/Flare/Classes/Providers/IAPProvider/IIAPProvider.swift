//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

public protocol IIAPProvider {
    /// False if this device is not able or allowed to make payments
    var canMakePayments: Bool { get }

    /// Retrieve localized information from the App Store about a specified list of products.
    ///
    /// - Parameters:
    ///   - productsIds: The list of product identifiers for the products you wish to retrieve descriptions of.
    ///   - completion: A products handler.
    func fetch(productsIds: Set<String>, completion: @escaping Closure<Result<[SKProduct], IAPError>>)
    
    /// Retrieve localized information from the App Store about a specified list of products.
    ///
    /// - Parameter productsIDs: The list of product identifiers for the products you wish to retrieve descriptions of.
    ///
    /// - Returns: Products.
    func fetch(productsIDs: Set<String>) async throws -> [SKProduct]
    
    /// Perform purchase a product with given id.
    ///
    /// - Parameters:
    ///   - productId: A product identifier.
    ///   - completion: A block object to be executed when the purchase operation ends.
    func purchase(productId: String, completion: @escaping Closure<Result<PaymentTransaction, IAPError>>)
    
    /// <#Description#>
    ///
    /// - Parameter productId: <#productId description#>
    /// 
    /// - Returns: <#description#>
    func purchase(productId: String) async throws -> PaymentTransaction

    /// A request to refresh the receipt, which represents the user’s transactions with your app.
    ///
    /// - Parameter completion: A block object to be executed when the refresh operation ends.
    func refreshReceipt(completion: @escaping Closure<Result<String, IAPError>>)
    
    /// <#Description#>
    /// - Returns: <#description#>
    func refreshReceipt() async throws -> String
    
    /// Remove a finished (i.e. failed or completed) transaction from the queue. Attempting to finish a purchasing transaction will throw an exception.
    ///
    /// - Parameter transaction: An object in the payment queue.
    func finish(transaction: PaymentTransaction)

    /// The transactions array will only be synchronized with the server while the queue has observers. This may require that the user authenticate.
    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?)

    /// The transactions array will only be synchronized with the server while the queue has observers. This may require that the user authenticate
    func removeTransactionObserver()
}
