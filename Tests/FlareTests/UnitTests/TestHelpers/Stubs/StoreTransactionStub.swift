//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class StoreTransactionStub: IStoreTransaction {
    var stubbedProductIdentifier: String! = UUID().uuidString

    var productIdentifier: String {
        stubbedProductIdentifier
    }

    var stubbedPurchaseDate: Date!

    var purchaseDate: Date {
        stubbedPurchaseDate
    }

    var stubbedHasKnownPurchaseDate: Bool! = false

    var hasKnownPurchaseDate: Bool {
        stubbedHasKnownPurchaseDate
    }

    var stubbedTransactionIdentifier: String! = ""

    var transactionIdentifier: String {
        stubbedTransactionIdentifier
    }

    var stubbedHasKnownTransactionIdentifier: Bool! = false

    var hasKnownTransactionIdentifier: Bool {
        stubbedHasKnownTransactionIdentifier
    }

    var stubbedQuantity: Int! = 0

    var quantity: Int {
        stubbedQuantity
    }

    var stubbedJwsRepresentation: String!

    var jwsRepresentation: String? {
        stubbedJwsRepresentation
    }

    var stubbedEnvironment: StoreEnvironment!

    var environment: StoreEnvironment? {
        stubbedEnvironment
    }
}
