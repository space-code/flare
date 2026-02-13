//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import struct Log.LogLevel
import StoreKit

#if os(iOS) || VISION_OS
    import UIKit
#endif

// MARK: - Flare

/// The class creates and manages in-app purchases.
public final class Flare {
    // MARK: Properties

    /// The in-app purchase provider.
    private let iapProvider: IIAPProvider

    /// The configuration provider.
    private let configurationProvider: IConfigurationProvider

    // The singleton instance.
    #if swift(>=6.0)
        private nonisolated(unsafe) static let flare: Flare = .init()
    #else
        private static let flare: Flare = .init()
    #endif

    /// Returns a shared `Flare` object.
    public static var shared: IFlare {
        flare
    }

    /// The log level.
    public var logLevel: LogLevel {
        get { Logger.logLevel }
        set { Logger.logLevel = newValue }
    }

    // MARK: Initialization

    /// Creates a new `Flare` instance.
    ///
    /// - Parameters:
    ///    - dependencies: The package's dependencies.
    ///    - configurationProvider: The configuration provider.
    init(dependencies: IFlareDependencies = FlareDependencies()) {
        iapProvider = dependencies.iapProvider
        configurationProvider = dependencies.configurationProvider
    }

    // MARK: Public

    /// Configures the Flare package with the provided configuration.
    ///
    /// - Parameters:
    ///   - configuration: The configuration object containing settings for Flare.
    public static func configure(with configuration: Configuration) {
        flare.configurationProvider.configure(with: configuration)
    }
}

// MARK: IFlare

extension Flare: IFlare {
    public func fetch(productIDs: some Collection<String>, completion: @escaping SendableClosure<Result<[StoreProduct], IAPError>>) {
        iapProvider.fetch(productIDs: productIDs, completion: completion)
    }

    public func fetch(productIDs: some Collection<String>) async throws -> [StoreProduct] {
        try await iapProvider.fetch(productIDs: productIDs)
    }

    public func purchase(
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping SendableClosure<Result<StoreTransaction, IAPError>>
    ) {
        guard checkIfUserCanMakePayments() else {
            completion(.failure(.paymentNotAllowed))
            return
        }

        iapProvider.purchase(product: product, promotionalOffer: promotionalOffer) { result in
            switch result {
            case let .success(transaction):
                completion(.success(transaction))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    public func purchase(product: StoreProduct, promotionalOffer: PromotionalOffer?) async throws -> StoreTransaction {
        guard checkIfUserCanMakePayments() else { throw IAPError.paymentNotAllowed }
        return try await iapProvider.purchase(product: product, promotionalOffer: promotionalOffer)
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    public func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping SendableClosure<Result<StoreTransaction, IAPError>>
    ) {
        guard checkIfUserCanMakePayments() else {
            completion(.failure(.paymentNotAllowed))
            return
        }
        iapProvider.purchase(product: product, options: options, promotionalOffer: promotionalOffer, completion: completion)
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    public func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?
    ) async throws -> StoreTransaction {
        guard checkIfUserCanMakePayments() else { throw IAPError.paymentNotAllowed }
        return try await iapProvider.purchase(product: product, options: options, promotionalOffer: promotionalOffer)
    }

    public func receipt(completion: @escaping SendableClosure<Result<String, IAPError>>) {
        iapProvider.refreshReceipt { result in
            switch result {
            case let .success(receipt):
                completion(.success(receipt))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    public func receipt() async throws -> String {
        try await iapProvider.refreshReceipt()
    }

    public func finish(transaction: StoreTransaction, completion: (@Sendable () -> Void)?) {
        iapProvider.finish(transaction: transaction, completion: completion)
    }

    public func finish(transaction: StoreTransaction) async {
        await iapProvider.finish(transaction: transaction)
    }

    public func addTransactionObserver(fallbackHandler: SendableClosure<Result<StoreTransaction, IAPError>>?) {
        iapProvider.addTransactionObserver(fallbackHandler: fallbackHandler)
    }

    public func removeTransactionObserver() {
        iapProvider.removeTransactionObserver()
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    public func checkEligibility(productIDs: Set<String>) async throws -> [String: SubscriptionEligibility] {
        try await iapProvider.checkEligibility(productIDs: productIDs)
    }

    public func restore() async throws {
        try await iapProvider.restore()
    }

    public func restore(_ completion: @escaping @Sendable (Result<Void, any Error>) -> Void) {
        iapProvider.restore(completion)
    }

    public func receipt(updateTransactions: Bool) async throws -> String {
        try await iapProvider.refreshReceipt(updateTransactions: updateTransactions)
    }

    public func receipt(updateTransactions: Bool, completion: @escaping @Sendable (Result<String, IAPError>) -> Void) {
        iapProvider.refreshReceipt(updateTransactions: updateTransactions, completion: completion)
    }

    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        public func beginRefundRequest(productID: String) async throws -> RefundRequestStatus {
            try await iapProvider.beginRefundRequest(productID: productID)
        }

        @available(iOS 14.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        public func presentCodeRedemptionSheet() {
            iapProvider.presentCodeRedemptionSheet()
        }

        @available(iOS 16.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        public func presentOfferCodeRedeemSheet() async throws {
            try await iapProvider.presentOfferCodeRedeemSheet()
        }
    #endif

    // MARK: Private

    private func checkIfUserCanMakePayments() -> Bool {
        guard iapProvider.canMakePayments else {
            Logger.error(message: L10n.Purchase.cannotPurcaseProduct)
            return false
        }
        return true
    }
}
