//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class StoreTransactionMock: IStoreTransaction, @unchecked Sendable {
    var invokedProductIdentifierGetter = false
    var invokedProductIdentifierGetterCount = 0
    var stubbedProductIdentifier: String! = ""

    var productIdentifier: String {
        invokedProductIdentifierGetter = true
        invokedProductIdentifierGetterCount += 1
        return stubbedProductIdentifier
    }

    var invokedPurchaseDateGetter = false
    var invokedPurchaseDateGetterCount = 0
    var stubbedPurchaseDate: Date!

    var purchaseDate: Date {
        invokedPurchaseDateGetter = true
        invokedPurchaseDateGetterCount += 1
        return stubbedPurchaseDate
    }

    var invokedHasKnownPurchaseDateGetter = false
    var invokedHasKnownPurchaseDateGetterCount = 0
    var stubbedHasKnownPurchaseDate: Bool! = false

    var hasKnownPurchaseDate: Bool {
        invokedHasKnownPurchaseDateGetter = true
        invokedHasKnownPurchaseDateGetterCount += 1
        return stubbedHasKnownPurchaseDate
    }

    var invokedTransactionIdentifierGetter = false
    var invokedTransactionIdentifierGetterCount = 0
    var stubbedTransactionIdentifier: String! = ""

    var transactionIdentifier: String {
        invokedTransactionIdentifierGetter = true
        invokedTransactionIdentifierGetterCount += 1
        return stubbedTransactionIdentifier
    }

    var invokedHasKnownTransactionIdentifierGetter = false
    var invokedHasKnownTransactionIdentifierGetterCount = 0
    var stubbedHasKnownTransactionIdentifier: Bool! = false

    var hasKnownTransactionIdentifier: Bool {
        invokedHasKnownTransactionIdentifierGetter = true
        invokedHasKnownTransactionIdentifierGetterCount += 1
        return stubbedHasKnownTransactionIdentifier
    }

    var invokedQuantityGetter = false
    var invokedQuantityGetterCount = 0
    var stubbedQuantity: Int! = 0

    var quantity: Int {
        invokedQuantityGetter = true
        invokedQuantityGetterCount += 1
        return stubbedQuantity
    }

    var invokedJwsRepresentationGetter = false
    var invokedJwsRepresentationGetterCount = 0
    var stubbedJwsRepresentation: String!

    var jwsRepresentation: String? {
        invokedJwsRepresentationGetter = true
        invokedJwsRepresentationGetterCount += 1
        return stubbedJwsRepresentation
    }

    var invokedEnvironmentGetter = false
    var invokedEnvironmentGetterCount = 0
    var stubbedEnvironment: StoreEnvironment!

    var environment: StoreEnvironment? {
        invokedEnvironmentGetter = true
        invokedEnvironmentGetterCount += 1
        return stubbedEnvironment
    }

    var invokedPriceGetter = false
    var invokedPriceGetterCount = 0
    var stubbedPrice: Decimal!

    var price: Decimal? {
        invokedPriceGetter = true
        invokedPriceGetterCount += 1
        return stubbedPrice
    }

    var invokedCurrencyGetter = false
    var invokedCurrencyGetterCount = 0
    var stubbedCurrency: String!

    var currency: String? {
        invokedCurrencyGetter = true
        invokedCurrencyGetterCount += 1
        return stubbedCurrency
    }

    var invokedOriginalID = false
    var invokedOriginalIDCount = 0
    var stubbedOriginalID: UInt64?
    var originalID: UInt64? {
        invokedOriginalID = true
        invokedOriginalIDCount += 1
        return stubbedOriginalID
    }
}
