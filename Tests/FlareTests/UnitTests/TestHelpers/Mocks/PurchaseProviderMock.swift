//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit

final class PurchaseProviderMock: IPurchaseProvider {
    var invokedFinish = false
    var invokedFinishCount = 0
    var invokedFinishParameters: (transaction: PaymentTransaction, Void)?
    var invokedFinishParametersList = [(transaction: PaymentTransaction, Void)]()

    func finish(transaction: PaymentTransaction) {
        invokedFinish = true
        invokedFinishCount += 1
        invokedFinishParameters = (transaction, ())
        invokedFinishParametersList.append((transaction, ()))
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

    var invokedPurchase = false
    var invokedPurchaseCount = 0
    var invokedPurchaseParameters: (product: StoreProduct, Void)?
    var invokedPurchaseParametersList = [(product: StoreProduct, Void)]()
    var stubbedPurchaseCompletionResult: (Result<StoreTransaction, IAPError>, Void)?

    @MainActor
    func purchase(product: StoreProduct, completion: @escaping PurchaseCompletionHandler) {
        invokedPurchase = true
        invokedPurchaseCount += 1
        invokedPurchaseParameters = (product, ())
        invokedPurchaseParametersList.append((product, ()))
        if let result = stubbedPurchaseCompletionResult {
            completion(result.0)
        }
    }

    var invokedPurchaseWithOptions = false
    var invokedPurchaseWithOptionsCount = 0
    var invokedPurchaseWithOptionsParameters: (product: StoreProduct, Any)?
    var invokedPurchaseWithOptionsParametersList = [(product: StoreProduct, Any)]()
    var stubbedinvokedPurchaseWithOptionsCompletionResult: (Result<StoreTransaction, IAPError>, Void)?

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    @MainActor
    func purchase(
        product: StoreProduct,
        options: Set<Product.PurchaseOption>,
        completion: @escaping PurchaseCompletionHandler
    ) {
        invokedPurchaseWithOptions = true
        invokedPurchaseWithOptionsCount += 1
        invokedPurchaseWithOptionsParameters = (product, options)
        invokedPurchaseWithOptionsParametersList.append((product, options))

        if let result = stubbedinvokedPurchaseWithOptionsCompletionResult {
            completion(result.0)
        }
    }
}