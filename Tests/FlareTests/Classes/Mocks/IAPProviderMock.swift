//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit

final class IAPProviderMock: IIAPProvider {
    var invokedCanMakePayments = false
    var invokedCanMakePaymentsCount = 0
    var stubbedCanMakePayments: Bool = false

    var canMakePayments: Bool {
        invokedCanMakePayments = true
        invokedCanMakePaymentsCount += 1
        return stubbedCanMakePayments
    }

    var invokedFetch = false
    var invokedFetchCount = 0
    var invokedFetchParameters: (productsIds: Set<String>, completion: Closure<Result<[SKProduct], IAPError>>)?
    var invokedFetchParametersList = [(productsIds: Set<String>, completion: Closure<Result<[SKProduct], IAPError>>)]()

    func fetch(productsIds: Set<String>, completion: @escaping Closure<Result<[SKProduct], IAPError>>) {
        invokedFetch = true
        invokedFetchCount += 1
        invokedFetchParameters = (productsIds, completion)
        invokedFetchParametersList.append((productsIds, completion))
    }

    var invokedPurchase = false
    var invokedPurchaseCount = 0
    var invokedPurchaseParameters: (productId: String, completion: Closure<Result<PaymentTransaction, IAPError>>)?
    var invokedPurchaseParametersList = [(productId: String, completion: Closure<Result<PaymentTransaction, IAPError>>)]()

    func purchase(productId: String, completion: @escaping Closure<Result<PaymentTransaction, IAPError>>) {
        invokedPurchase = true
        invokedPurchaseCount += 1
        invokedPurchaseParameters = (productId, completion)
        invokedPurchaseParametersList.append((productId, completion))
    }

    var invokedRefreshReceipt = false
    var invokedRefreshReceiptCount = 0
    var invokedRefreshReceiptParameters: (Closure<Result<String, IAPError>>, Void)?
    var invokedRefreshReceiptParametersList = [(Closure<Result<String, IAPError>>, Void)]()

    func refreshReceipt(completion: @escaping Closure<Result<String, IAPError>>) {
        invokedRefreshReceipt = true
        invokedRefreshReceiptCount += 1
        invokedRefreshReceiptParameters = (completion, ())
        invokedRefreshReceiptParametersList.append((completion, ()))
    }

    var invokedFinishTransaction = false
    var invokedFinishTransactionCount = 0
    var invokedFinishTransactionParameters: (PaymentTransaction, Void)?
    var invokedFinishTransactionParanetersList = [(PaymentTransaction, Void)]()

    func finish(transaction: PaymentTransaction) {
        invokedFinishTransaction = true
        invokedFinishTransactionCount += 1
        invokedFinishTransactionParameters = (transaction, ())
        invokedFinishTransactionParanetersList.append((transaction, ()))
    }

    var invokedAddTransactionObserver = false
    var invokedAddTransactionObserverCount = 0
    var invokedAddTransactionObserverParameters: (fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?, Void)?
    var invokedAddTransactionObserverParametersList = [(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?, Void)]()

    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?) {
        invokedAddTransactionObserver = true
        invokedAddTransactionObserverCount += 1
        invokedAddTransactionObserverParameters = (fallbackHandler, ())
        invokedAddTransactionObserverParametersList.append((fallbackHandler, ()))
    }

    var invokedRemoveTransactionObserver = false
    var invokedRemoveTransactionObserverCount = 0

    func removeTransactionObserver() {
        invokedRemoveTransactionObserver = true
        invokedRemoveTransactionObserverCount += 1
    }
}
