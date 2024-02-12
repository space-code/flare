//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class StoreTransactionMock: IStoreTransaction {
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
}
