//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - PaymentMode

/// The offer's payment mode.
public enum PaymentMode: Int, Sendable {
    /// Price is charged one or more times
    case payAsYouGo = 0
    /// Price is charged once in advance
    case payUpFront = 1
    /// No initial charge
    case freeTrial = 2
}

extension PaymentMode {
    /// Creates a ``PaymentMode`` instance.
    ///
    /// - Parameter productDiscount: The details of an introductory offer or a promotional
    ///                              offer for an auto-renewable subscription.
    ///
    /// - Returns: A payment mode.
    static func from(productDiscount: SKProductDiscount) -> Self? {
        switch productDiscount.paymentMode {
        case .payAsYouGo:
            return .payAsYouGo
        case .payUpFront:
            return .payUpFront
        case .freeTrial:
            return .freeTrial
        @unknown default:
            return nil
        }
    }

    /// Creates a ``PaymentMode`` instance.
    ///
    /// - Parameter discount: Information about a subscription offer that you configure in App Store Connect.
    ///
    /// - Returns: A payment mode.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    static func from(discount: Product.SubscriptionOffer) -> Self? {
        switch discount.paymentMode {
        case Product.SubscriptionOffer.PaymentMode.freeTrial:
            return .freeTrial
        case Product.SubscriptionOffer.PaymentMode.payAsYouGo:
            return .payAsYouGo
        case Product.SubscriptionOffer.PaymentMode.payUpFront:
            return .payUpFront
        default:
            return nil
        }
    }
}
