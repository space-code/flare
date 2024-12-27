//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

// MARK: - IIAPProvider

/// Type that provides in-app purchase functionality.
public protocol IIAPProvider {
    /// False if this device is not able or allowed to make payments
    var canMakePayments: Bool { get }

    /// Retrieves localized information from the App Store about a specified list of products.
    ///
    /// - Parameters:
    ///   - productIDs: The list of product identifiers for which you wish to retrieve descriptions.
    ///   - completion: The completion containing the response of retrieving products.
    func fetch(productIDs: some Collection<String>, completion: @escaping SendableClosure<Result<[StoreProduct], IAPError>>)

    /// Retrieves localized information from the App Store about a specified list of products.
    ///
    /// - Parameter productIDs: The list of product identifiers for which you wish to retrieve descriptions.
    ///
    /// - Throws: `IAPError(error:)` if the request did fail with error.
    ///
    /// - Returns: An array of products.
    func fetch(productIDs: some Collection<String>) async throws -> [StoreProduct]

    /// Performs a purchase of a product.
    ///
    /// - Note: The method automatically checks if the user can purchase a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - promotionalOffer: The promotional offer.
    ///   - completion: The closure to be executed once the purchase is complete.
    func purchase(
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping SendableClosure<Result<StoreTransaction, IAPError>>
    )

    /// Purchases a product.
    ///
    /// - Note: The method automatically checks if the user can purchase a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - promotionalOffer: The promotional offer.
    ///
    /// - Throws: `IAPError.paymentNotAllowed` if user can't make payment.
    ///
    /// - Returns: A payment transaction.
    func purchase(product: StoreProduct, promotionalOffer: PromotionalOffer?) async throws -> StoreTransaction

    /// Purchases a product with a given ID.
    ///
    /// - Note: The method automatically checks if the user can purchase a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - options: The optional settings for a product purchase.
    ///   - promotionalOffer: The promotional offer.
    ///   - completion: The closure to be executed once the purchase is complete.
    ///
    /// - Throws: `IAPError.paymentNotAllowed` if user can't make payment.
    ///
    /// - Returns: A payment transaction.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping SendableClosure<Result<StoreTransaction, IAPError>>
    )

    /// Purchases a product with a given ID.
    ///
    /// - Note: The method automatically checks if the user can purchase a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - options: The optional settings for a product purchase.
    ///   - promotionalOffer: The promotional offer.
    ///
    /// - Throws: `IAPError.paymentNotAllowed` if user can't make payment.
    ///
    /// - Returns: A payment transaction.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?
    ) async throws -> StoreTransaction

    /// Refreshes the receipt and optionally updates transactions.
    ///
    /// - Parameters:
    ///   - updateTransactions: A boolean indicating whether to update transactions.
    ///     - If `true`, the method will refresh completed transactions.
    ///     - If `false`, only the receipt will be refreshed.
    ///   - completion: A closure that gets called with the result of the refresh operation.
    ///     - On success, it returns a `Result<String, IAPError>` containing the updated receipt information as a `String`.
    ///     - On failure, it returns a `Result<String, IAPError>` with an `IAPError` describing the issue.
    ///
    /// - Note: Use this method to handle asynchronous receipt refreshing and transaction updates with completion handler feedback.
    func refreshReceipt(updateTransactions: Bool, completion: @escaping SendableClosure<Result<String, IAPError>>)

    /// Refreshes the receipt and optionally updates transactions.
    ///
    /// - Parameter updateTransactions: A boolean indicating whether to update transactions.
    ///   - If `true`, the method will refresh completed transactions.
    ///   - If `false`, only the receipt will be refreshed.
    ///
    /// - Returns: A `String` containing the updated receipt information.
    ///
    /// - Throws: An `IAPError` if the refresh process encounters an issue.
    ///
    /// - Note: Use this method for an asynchronous refresh operation with error handling and receipt data retrieval.
    func refreshReceipt(updateTransactions: Bool) async throws -> String

    /// Refreshes the receipt, representing the user's transactions with your app.
    ///
    /// - Parameter completion: The closure to be executed when the refresh operation ends.
    func refreshReceipt(completion: @escaping SendableClosure<Result<String, IAPError>>)

    /// Refreshes the receipt, representing the user's transactions with your app.
    ///
    /// `IAPError(error:)` if the request did fail with error.
    ///
    /// - Returns: A receipt.
    func refreshReceipt() async throws -> String

    /// Removes a finished (i.e. failed or completed) transaction from the queue.
    /// Attempting to finish a purchasing transaction will throw an exception.
    ///
    /// - Parameters:
    ///   - transaction: An object in the payment queue.
    ///   - completion: If a completion closure is provided, call it after finishing the transaction.
    func finish(transaction: StoreTransaction, completion: (@Sendable () -> Void)?)

    /// Removes a finished (i.e. failed or completed) transaction from the queue.
    /// Attempting to finish a purchasing transaction will throw an exception.
    ///
    /// - Parameters:
    ///   - transaction: An object in the payment queue.
    func finish(transaction: StoreTransaction) async

    /// Adds transaction observer to the payment queue.
    /// The transactions array will only be synchronized with the server while the queue has observers.
    ///
    /// - Note: This may require that the user authenticate.
    func addTransactionObserver(fallbackHandler: SendableClosure<Result<StoreTransaction, IAPError>>?)

    /// Removes transaction observer from the payment queue.
    /// The transactions array will only be synchronized with the server while the queue has observers.
    ///
    /// - Note: This may require that the user authenticate.
    func removeTransactionObserver()

    /// Checks whether products are eligible for promotional offers
    ///
    /// - Parameter productIDs: The list of product identifiers for which you wish to check eligibility.
    ///
    /// - Returns: An array that contains information about the eligibility of products.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func checkEligibility(productIDs: Set<String>) async throws -> [String: SubscriptionEligibility]

    /// Restores completed transactions.
    ///
    /// This method initiates the process of restoring any previously completed transactions.
    /// It is an asynchronous function that might throw an error if the restoration fails.
    ///
    /// - Throws: An error if the restoration process encounters an issue.
    ///
    /// - Note: This method should be called when you need to restore purchases made by the user on a different device or after
    /// reinstallation.
    func restore() async throws

    /// Restores completed transactions.
    ///
    /// This method initiates the process of restoring any previously completed transactions.
    /// It uses a completion handler to provide the result of the restoration process.
    ///
    /// - Parameter completion: A closure that gets called with a `Result` indicating success or failure of the restoration.
    ///   - On success, it returns `Result<Void, Error>.success(())`.
    ///   - On failure, it returns `Result<Void, Error>.failure(Error)` with an error describing the issue.
    ///
    /// - Note: Use this method when you need to handle the restoration process asynchronously and provide feedback through the completion
    /// handler.
    func restore(_ completion: @escaping @Sendable (Result<Void, Error>) -> Void)

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

        /// Displays a sheet that enables users to redeem subscription offer codes that you configure in App Store Connect.
        @available(iOS 14.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func presentCodeRedemptionSheet()

        /// Displays a sheet in the window scene that enables users to redeem
        /// a subscription offer code that you configure in App Store
        /// Connect.
        @available(iOS 16.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func presentOfferCodeRedeemSheet() async throws
    #endif
}

extension IIAPProvider {
    /// Performs a purchase of a product.
    ///
    /// - Note: The method automatically checks if the user can purchase a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - completion: The closure to be executed once the purchase is complete.
    func purchase(
        product: StoreProduct,
        completion: @escaping SendableClosure<Result<StoreTransaction, IAPError>>
    ) {
        purchase(product: product, promotionalOffer: nil, completion: completion)
    }

    /// Purchases a product.
    ///
    /// - Note: The method automatically checks if the user can purchase a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameter product: The product to be purchased.
    ///
    /// - Throws: `IAPError.paymentNotAllowed` if user can't make payment.
    ///
    /// - Returns: A payment transaction.
    func purchase(product: StoreProduct) async throws -> StoreTransaction {
        try await purchase(product: product, promotionalOffer: nil)
    }

    /// Purchases a product with a given ID.
    ///
    /// - Note: The method automatically checks if the user can purchase a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - options: The optional settings for a product purchase.
    ///   - completion: The closure to be executed once the purchase is complete.
    ///
    /// - Throws: `IAPError.paymentNotAllowed` if user can't make payment.
    ///
    /// - Returns: A payment transaction.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        completion: @escaping SendableClosure<Result<StoreTransaction, IAPError>>
    ) {
        purchase(product: product, options: options, promotionalOffer: nil, completion: completion)
    }

    /// Purchases a product with a given ID.
    ///
    /// - Note: The method automatically checks if the user can purchase a product.
    ///         If the user can't make a payment, the method returns an error
    ///         with the type `IAPError.paymentNotAllowed`.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - options: The optional settings for a product purchase.
    ///
    /// - Throws: `IAPError.paymentNotAllowed` if user can't make payment.
    ///
    /// - Returns: A payment transaction.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>
    ) async throws -> StoreTransaction {
        try await purchase(product: product, options: options, promotionalOffer: nil)
    }
}
