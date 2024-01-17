//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
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

    static var subscriptions: [StoreKit.Product] {
        get async throws {
            try await subscriptionsWithOffers + subscriptionsWithoutOffers
        }
    }

    static var subscriptionsWithOffers: [StoreKit.Product] {
        get async throws {
            try await StoreKit.Product.products(for: [.subscription1ID])
        }
    }

    static var subscriptionsWithoutOffers: [StoreKit.Product] {
        get async throws {
            try await StoreKit.Product.products(for: [.subscription2ID])
        }
    }

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
    static let testNonConsumableID = "com.flare.test_non_consumable_purchase_1"

    /// The subscription's id with introductionary offer
    static let subscription1ID = "subscription_1"

    /// The subscription's id without introductionary offer
    static let subscription2ID = "subscription_2"
}
