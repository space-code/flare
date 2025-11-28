//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - DiscountType

/// The type of discount offer.
public enum DiscountType: Int, Sendable {
    /// Introductory offer
    case introductory = 0
    /// Promotional offer for subscriptions
    case promotional = 1
}

extension DiscountType {
    /// Creates a ``DiscountType`` instance.
    ///
    /// - Parameter productDiscount: The details of an introductory offer or a promotional
    ///                              offer for an auto-renewable subscription.
    ///
    /// - Returns: A discount type.
    static func from(productDiscount: SKProductDiscount) -> Self? {
        switch productDiscount.type {
        case .introductory:
            return .introductory
        case .subscription:
            return .promotional
        @unknown default:
            return nil
        }
    }

    /// Creates a ``DiscountType`` instance.
    ///
    /// - Parameter discount: Information about a subscription offer that you configure in App Store Connect.
    ///
    /// - Returns: A discount type.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    static func from(discount: Product.SubscriptionOffer) -> Self? {
        switch discount.type {
        case Product.SubscriptionOffer.OfferType.introductory:
            .introductory
        case Product.SubscriptionOffer.OfferType.promotional:
            .promotional
        default:
            nil
        }
    }
}
