//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

#if os(iOS) || VISION_OS
    import UIKit
#endif

// MARK: - Flare

/// The class creates and manages in-app purchases.
public final class Flare {
    // MARK: Initialization

    /// Creates a new `Flare` instance.
    ///
    /// - Parameter iapProvider: The in-app purchase provider.
    init(iapProvider: IIAPProvider = IAPProvider()) {
        self.iapProvider = iapProvider
    }

    // MARK: Public

    /// Returns a default `Flare` object.
    public static let `default`: IFlare = Flare()

    // MARK: Private

    /// The in-app purchase provider.
    private let iapProvider: IIAPProvider
}

// MARK: IFlare

extension Flare: IFlare {
    public func fetch(productIDs: Set<String>, completion: @escaping Closure<Result<[StoreProduct], IAPError>>) {
        iapProvider.fetch(productIDs: productIDs, completion: completion)
    }

    public func fetch(productIDs: Set<String>) async throws -> [StoreProduct] {
        try await iapProvider.fetch(productIDs: productIDs)
    }

    public func purchase(productID: String, completion: @escaping Closure<Result<PaymentTransaction, IAPError>>) {
        guard iapProvider.canMakePayments else {
            completion(.failure(.paymentNotAllowed))
            return
        }

        iapProvider.purchase(productID: productID) { result in
            switch result {
            case let .success(transaction):
                completion(.success(transaction))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    public func purchase(productID: String) async throws -> PaymentTransaction {
        guard iapProvider.canMakePayments else { throw IAPError.paymentNotAllowed }
        return try await iapProvider.purchase(productID: productID)
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

    public func finish(transaction: PaymentTransaction) {
        iapProvider.finish(transaction: transaction)
    }

    public func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?) {
        iapProvider.addTransactionObserver(fallbackHandler: fallbackHandler)
    }

    public func removeTransactionObserver() {
        iapProvider.removeTransactionObserver()
    }

    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        public func beginRefundRequest(productID: String) async throws -> RefundRequestStatus {
            try await iapProvider.beginRefundRequest(productID: productID)
        }
    #endif
}
