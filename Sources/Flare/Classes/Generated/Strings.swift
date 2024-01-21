// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Flare {
    /// Flare configured with configuration:
    /// %@
    internal static func initWithConfiguration(_ p1: Any) -> String {
      return L10n.tr("Localizable", "flare.init_with_configuration", String(describing: p1), fallback: "Flare configured with configuration:\n%@")
    }
  }
  internal enum Payment {
    /// Adding payment for product: %s. %i transactions already in the queue
    internal static func paymentQueueAddingPayment(_ p1: UnsafePointer<CChar>, _ p2: Int) -> String {
      return L10n.tr("Localizable", "payment.payment_queue_adding_payment", p1, p2, fallback: "Adding payment for product: %s. %i transactions already in the queue")
    }
  }
  internal enum Products {
    /// Requested products %@ not found.
    internal static func requestedProductsNotFound(_ p1: Any) -> String {
      return L10n.tr("Localizable", "products.requested_products_not_found", String(describing: p1), fallback: "Requested products %@ not found.")
    }
    /// Requested products %@ have been received
    internal static func requestedProductsReceived(_ p1: Any) -> String {
      return L10n.tr("Localizable", "products.requested_products_received", String(describing: p1), fallback: "Requested products %@ have been received")
    }
  }
  internal enum Purchase {
    /// This device is not able or allowed to make payments.
    internal static let cannotPurcaseProduct = L10n.tr("Localizable", "purchase.cannot_purcase_product", fallback: "This device is not able or allowed to make payments.")
    /// Finishing transaction %s for product identifier: %s
    internal static func finishingTransaction(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "purchase.finishing_transaction", p1, p2, fallback: "Finishing transaction %s for product identifier: %s")
    }
    /// Product purchase for %s failed with error: %s
    internal static func productPurchaseFailed(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "purchase.product_purchase_failed", p1, p2, fallback: "Product purchase for %s failed with error: %s")
    }
    /// Purchased product: %s
    internal static func purchasedProduct(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "purchase.purchased_product", p1, fallback: "Purchased product: %s")
    }
    /// Purchasing product: %s
    internal static func purchasingProduct(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "purchase.purchasing_product", p1, fallback: "Purchasing product: %s")
    }
    /// Purchasing product %s with offer %s
    internal static func purchasingProductWithOffer(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "purchase.purchasing_product_with_offer", p1, p2, fallback: "Purchasing product %s with offer %s")
    }
    /// Transaction for productID: %s not found.
    internal static func transactionNotFound(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "purchase.transaction_not_found", p1, fallback: "Transaction for productID: %s not found.")
    }
    /// Transaction for productID: %s is unverified by the App Store. Verification error: %s.
    internal static func transactionUnverified(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "purchase.transaction_unverified", p1, p2, fallback: "Transaction for productID: %s is unverified by the App Store. Verification error: %s.")
    }
  }
  internal enum Receipt {
    /// Refreshed receipt. Request id: %s.
    internal static func refreshedReceipt(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "receipt.refreshed_receipt", p1, fallback: "Refreshed receipt. Request id: %s.")
    }
    /// Refreshing receipt. Request id: %s.
    internal static func refreshingReceipt(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "receipt.refreshing_receipt", p1, fallback: "Refreshing receipt. Request id: %s.")
    }
    /// Refreshing receipt failed with error: %s. Request id: %s.
    internal static func refreshingReceiptFailed(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "receipt.refreshing_receipt_failed", p1, p2, fallback: "Refreshing receipt failed with error: %s. Request id: %s.")
    }
  }
  internal enum Redeem {
    /// Presenting code redemption sheet.
    internal static let presentingCodeRedemptionSheet = L10n.tr("Localizable", "redeem.presenting_code_redemption_sheet", fallback: "Presenting code redemption sheet.")
    /// Presenting offer code redeem sheet
    internal static let presentingOfferCodeRedeemSheet = L10n.tr("Localizable", "redeem.presenting_offer_code_redeem_sheet", fallback: "Presenting offer code redeem sheet")
    /// Unable to present offer code redeem sheet due to unexpected error: %s
    internal static func unableToPresentOfferCodeRedeemSheet(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "redeem.unable_to_present_offer_code_redeem_sheet", p1, fallback: "Unable to present offer code redeem sheet due to unexpected error: %s")
    }
  }
  internal enum Refund {
    /// Refund has already requested for this product: %s
    internal static func duplicateRefundRequest(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "refund.duplicate_refund_request", p1, fallback: "Refund has already requested for this product: %s")
    }
    /// Refund request submission failed: %s
    internal static func failedRefundRequest(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "refund.failed_refund_request", p1, fallback: "Refund request submission failed: %s")
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
