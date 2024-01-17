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
            try await subscriptionsWithIntroductoryOffer + subscriptionsWithoutOffers + subscriptonsWithOffers
        }
    }

    static var subscriptionsWithIntroductoryOffer: [StoreKit.Product] {
        get async throws {
            try await StoreKit.Product.products(for: [.subscription1ID])
        }
    }

    static var subscriptionsWithoutOffers: [StoreKit.Product] {
        get async throws {
            try await StoreKit.Product.products(for: [.subscription2ID])
        }
    }

    static var subscriptonsWithOffers: [StoreKit.Product] {
        get async throws {
            try await StoreKit.Product.products(for: [.subscription3ID])
        }
    }
}

// MARK: - Constants

private extension String {
    static let testNonConsumableID = "com.flare.test_non_consumable_purchase_1"

    /// The subscription's id with introductory offer
    static let subscription1ID = "com.flare.monthly_1.99_week_intro"

    /// The subscription's id without introductory offer
    static let subscription2ID = "com.flare.monthly_0.99"

    /// The subscription's id with promotional offer
    static let subscription3ID = "com.flare.monthly_1.99_two_weeks_offer.free"
}
