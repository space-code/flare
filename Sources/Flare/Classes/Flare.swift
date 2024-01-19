//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
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

    /// The singleton instance.
    private static let flare: Flare = .init()

    /// Returns a shared `Flare` object.
    public static var shared: IFlare { flare }

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
    public func fetch(productIDs: Set<String>, completion: @escaping Closure<Result<[StoreProduct], IAPError>>) {
        iapProvider.fetch(productIDs: productIDs, completion: completion)
    }

    public func fetch(productIDs: Set<String>) async throws -> [StoreProduct] {
        try await iapProvider.fetch(productIDs: productIDs)
    }

    public func purchase(
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping Closure<Result<StoreTransaction, IAPError>>
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

    public func receipt(completion: @escaping Closure<Result<String, IAPError>>) {
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

    public func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?) {
        iapProvider.addTransactionObserver(fallbackHandler: fallbackHandler)
    }

    public func removeTransactionObserver() {
        iapProvider.removeTransactionObserver()
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    public func checkEligibility(productIDs: Set<String>) async throws -> [String: SubscriptionEligibility] {
        try await iapProvider.checkEligibility(productIDs: productIDs)
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
