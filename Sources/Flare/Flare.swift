//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

// MARK: - Flare

public final class Flare {
    // MARK: Initialization

    init(iapProvider: IIAPProvider = IAPProvider()) {
        self.iapProvider = iapProvider
    }

    // MARK: Public

    public static let `default`: IFlare = Flare()

    // MARK: Private

    private let iapProvider: IIAPProvider
}

// MARK: IFlare

extension Flare: IFlare {
    public func fetch(ids: Set<String>, completion: @escaping Closure<Result<[SKProduct], IAPError>>) {
        iapProvider.fetch(productsIds: ids, completion: completion)
    }

    public func buy(id: String, completion: @escaping Closure<Result<PaymentTransaction, IAPError>>) {
        guard iapProvider.canMakePayments else {
            completion(.failure(.paymentNotAllowed))
            return
        }

        iapProvider.purchase(productId: id) { result in
            switch result {
            case let .success(transaction):
                completion(.success(transaction))
            case let .failure(error):
                completion(.failure(error))
            }
        }
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

    public func finish(transaction: PaymentTransaction) {
        iapProvider.finish(transaction: transaction)
    }

    public func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?) {
        iapProvider.addTransactionObserver(fallbackHandler: fallbackHandler)
    }

    public func removeTransactionObserver() {
        iapProvider.removeTransactionObserver()
    }
}
