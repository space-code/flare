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
    internal enum Subscription {
      /// %@/%@
      internal static func price(_ p1: Any, _ p2: Any) -> String {
        return L10n.tr("Localizable", "product.subscription.price", String(describing: p1), String(describing: p2), fallback: "%@/%@")
      }
      internal enum Duration {
        /// Day
        internal static let day = L10n.tr("Localizable", "product.subscription.duration.day", fallback: "Day")
        /// Month
        internal static let month = L10n.tr("Localizable", "product.subscription.duration.month", fallback: "Month")
        /// Week
        internal static let week = L10n.tr("Localizable", "product.subscription.duration.week", fallback: "Week")
        /// Year
        internal static let year = L10n.tr("Localizable", "product.subscription.duration.year", fallback: "Year")
      }
    }
  }
  internal enum StoreButton {
    /// Restore Missing Purchases
    internal static let restorePurchases = L10n.tr("Localizable", "store_button.restore_purchases", fallback: "Restore Missing Purchases")
  }
  internal enum StoreUnavailable {
    /// No in-app purchases are availiable in the current storefront.
    internal static let message = L10n.tr("Localizable", "store_unavailable.message", fallback: "No in-app purchases are availiable in the current storefront.")
    /// Store Unavailable
    internal static let title = L10n.tr("Localizable", "store_unavailable.title", fallback: "Store Unavailable")
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
