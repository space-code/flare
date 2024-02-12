//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - SubscriptionPeriod

/// A class representing a subscription period with a specific value and unit.
public final class SubscriptionPeriod: NSObject, Sendable {
    // MARK: Types

    public enum Unit: Int, Sendable {
        /// A subscription period unit of a day.
        case day = 0
        /// A subscription period unit of a week.
        case week = 1
        /// A subscription period unit of a month.
        case month = 2
        /// A subscription period unit of a year.
        case year = 3
    }

    // MARK: Properties

    /// The numeric value of the subscription period.
    public let value: Int
    /// The unit of the subscription period (day, week, month, year).
    public let unit: Unit

    // MARK: Initialization

    /// Initializes a new `SubscriptionPeriod` instance.
    ///
    /// - Parameters:
    ///   - value: The numeric value of the subscription period.
    ///   - unit: The unit of the subscription period.
    public init(value: Int, unit: Unit) {
        self.value = value
        self.unit = unit
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? SubscriptionPeriod else { return false }
        return value == other.value && unit == other.unit
    }

    override public var hash: Int {
        var hasher = Hasher()
        hasher.combine(value)
        hasher.combine(unit)

        return hasher.finalize()
    }
}

// MARK: - Helpers

extension SubscriptionPeriod {
    @available(iOS 11.2, macOS 10.13.2, tvOS 11.2, watchOS 6.2, *)
    static func from(subscriptionPeriod: SKProductSubscriptionPeriod) -> SubscriptionPeriod? {
        guard let unit = SubscriptionPeriod.Unit.from(unit: subscriptionPeriod.unit) else {
            return nil
        }
        return SubscriptionPeriod(value: subscriptionPeriod.numberOfUnits, unit: unit)
    }

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8, *)
    static func from(subscriptionPeriod: StoreKit.Product.SubscriptionPeriod) -> SubscriptionPeriod? {
        guard let unit = SubscriptionPeriod.Unit.from(unit: subscriptionPeriod.unit) else {
            return nil
        }
        return SubscriptionPeriod(value: subscriptionPeriod.value, unit: unit)
    }
}

// MARK: - Extensions

private extension SubscriptionPeriod.Unit {
    /// Creates a ``SubscriptionPeriod.Unit`` instance.
    ///
    /// - Parameter unit: Values representing the duration of an interval, from a day up to a year.
    ///
    /// - Returns: A subscription unit.
    static func from(unit: SKProduct.PeriodUnit) -> Self? {
        switch unit {
        case .day:
            return .day
        case .week:
            return .week
        case .month:
            return .month
        case .year:
            return .year
        @unknown default:
            return nil
        }
    }

    /// Creates a ``SubscriptionPeriod.Unit`` instance.
    ///
    /// - Parameter unit: Units of time that describe subscription periods.
    ///
    /// - Returns: A subscription unit.
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8, *)
    static func from(unit: StoreKit.Product.SubscriptionPeriod.Unit) -> Self? {
        switch unit {
        case .day:
            return .day
        case .week:
            return .week
        case .month:
            return .month
        case .year:
            return .year
        @unknown default:
            return nil
        }
    }
}
