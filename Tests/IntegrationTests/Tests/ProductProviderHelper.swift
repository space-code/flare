//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

// MARK: - ProductProviderHelper

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
enum ProductProviderHelper {
    static var purchases: [StoreKit.Product] {
        get async throws {
            try await StoreKit.Product.products(for: [.testNonConsumableID])
        }
    }

//    static var subscriptions: [StoreKit.Product] {
//        get async throws {
//            try await StoreKit.Product.products(for: [.testSubscription1ID, .testSubscription2ID])
//        }
//    }
//
//    static var all: [StoreKit.Product] {
//        get async throws {
//            let purchases = try await self.purchases
//            let subscriptions = try await self.subscriptions
//
//            return purchases + subscriptions
//        }
//    }
}

// MARK: - Constants

private extension String {
    static let testPurchase1ID = "com.flare.test_purchase_1"
    static let testPurchase2ID = "com.flare.test_purchase_2"

    static let testNonConsumableID = "com.flare.test_non_consumable_purchase_1"

//    static let testSubscription1ID = "com.flare.test_subscription_1"
//    static let testSubscription2ID = "com.flare.test_subscription_2"
}
