// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Error {
    internal enum Default {
      /// Error Occurred
      internal static let title = L10n.tr("Localizable", "error.default.title", fallback: "Error Occurred")
    }
  }
  internal enum Product {
    /// Every %@
    internal static func priceDescription(_ p1: Any) -> String {
      return L10n.tr("Localizable", "product.price_description", String(describing: p1), fallback: "Every %@")
    }
    internal enum Subscription {
      /// %@/%@
      internal static func price(_ p1: Any, _ p2: Any) -> String {
        return L10n.tr("Localizable", "product.subscription.price", String(describing: p1), String(describing: p2), fallback: "%@/%@")
      }
    }
  }
  internal enum StoreButton {
    /// Restore Missing Purchases
    internal static let restorePurchases = L10n.tr("Localizable", "store_button.restore_purchases", fallback: "Restore Missing Purchases")
  }
  internal enum StoreUnavailable {
    /// Store Unavailable
    internal static let title = L10n.tr("Localizable", "store_unavailable.title", fallback: "Store Unavailable")
    internal enum Product {
      /// No in-app purchases are available in the current storefront.
      internal static let message = L10n.tr("Localizable", "store_unavailable.product.message", fallback: "No in-app purchases are available in the current storefront.")
    }
    internal enum Subscription {
      /// The subscription is unavailable in the current storefront.
      internal static let message = L10n.tr("Localizable", "store_unavailable.subscription.message", fallback: "The subscription is unavailable in the current storefront.")
    }
  }
  internal enum Subscription {
    internal enum Loading {
      /// Loading Subscriptions...
      internal static let message = L10n.tr("Localizable", "subscription.loading.message", fallback: "Loading Subscriptions...")
    }
  }
  internal enum Subscriptions {
    internal enum Renewable {
      /// Plan auto-renews for %@ until cancelled.
      internal static func subscriptionDescription(_ p1: Any) -> String {
        return L10n.tr("Localizable", "subscriptions.renewable.subscription_description", String(describing: p1), fallback: "Plan auto-renews for %@ until cancelled.")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
