// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Error {
    internal enum FailedToDecodeSignature {
      /// Decoding the signature has failed. The signature: %s
      internal static func description(_ p1: UnsafePointer<CChar>) -> String {
        return L10n.tr("Localizable", "error.failed_to_decode_signature.description", p1, fallback: "Decoding the signature has failed. The signature: %s")
      }
    }
    internal enum InvalidProductIds {
      /// Invalid product IDs: %@
      internal static func description(_ p1: Any) -> String {
        return L10n.tr("Localizable", "error.invalid_product_ids.description", String(describing: p1), fallback: "Invalid product IDs: %@")
      }
    }
    internal enum PaymentCancelled {
      /// The payment was canceled by the user.
      internal static let description = L10n.tr("Localizable", "error.payment_cancelled.description", fallback: "The payment was canceled by the user.")
    }
    internal enum PaymentDefferred {
      /// The purchase is pending, and requires action from the customer.
      internal static let description = L10n.tr("Localizable", "error.payment_defferred.description", fallback: "The purchase is pending, and requires action from the customer.")
    }
    internal enum PaymentNotAllowed {
      /// The current user is not eligible to make payments.
      internal static let description = L10n.tr("Localizable", "error.payment_not_allowed.description", fallback: "The current user is not eligible to make payments.")
      /// The payment card may have purchase restrictions, such as set limits or unavailability for online shopping.
      internal static let failureReason = L10n.tr("Localizable", "error.payment_not_allowed.failure_reason", fallback: "The payment card may have purchase restrictions, such as set limits or unavailability for online shopping.")
      /// Please check the payment card purchase restrictions.
      internal static let recoverySuggestion = L10n.tr("Localizable", "error.payment_not_allowed.recovery_suggestion", fallback: "Please check the payment card purchase restrictions.")
    }
    internal enum Receipt {
      /// The receipt could not be found.
      internal static let description = L10n.tr("Localizable", "error.receipt.description", fallback: "The receipt could not be found.")
    }
    internal enum Refund {
      /// The error occurred during the refund: %s
      internal static func description(_ p1: UnsafePointer<CChar>) -> String {
        return L10n.tr("Localizable", "error.refund.description", p1, fallback: "The error occurred during the refund: %s")
      }
    }
    internal enum StoreProductNotAvailable {
      /// The store product is currently unavailable.
      internal static let description = L10n.tr("Localizable", "error.store_product_not_available.description", fallback: "The store product is currently unavailable.")
      /// Make sure to create a product with the given identifier in App Store Connect.
      internal static let recoverySuggestion = L10n.tr("Localizable", "error.store_product_not_available.recovery_suggestion", fallback: "Make sure to create a product with the given identifier in App Store Connect.")
    }
    internal enum TransactionNotFound {
      /// Transaction for productID: %s couldn't be found.
      internal static func description(_ p1: UnsafePointer<CChar>) -> String {
        return L10n.tr("Localizable", "error.transaction_not_found.description", p1, fallback: "Transaction for productID: %s couldn't be found.")
      }
    }
    internal enum Unknown {
      /// The SKPayment returned unknown error.
      internal static let description = L10n.tr("Localizable", "error.unknown.description", fallback: "The SKPayment returned unknown error.")
    }
    internal enum Verification {
      /// The verification has failed with the following error: %s
      internal static func description(_ p1: UnsafePointer<CChar>) -> String {
        return L10n.tr("Localizable", "error.verification.description", p1, fallback: "The verification has failed with the following error: %s")
      }
    }
    internal enum With {
      /// The error ocurred: %s
      internal static func description(_ p1: UnsafePointer<CChar>) -> String {
        return L10n.tr("Localizable", "error.with.description", p1, fallback: "The error ocurred: %s")
      }
    }
  }
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
  internal enum RefundError {
    internal enum DuplicateRequest {
      /// The request has been duplicated.
      internal static let description = L10n.tr("Localizable", "refund_error.duplicate_request.description", fallback: "The request has been duplicated.")
    }
    internal enum Failed {
      /// The refund request failed.
      internal static let description = L10n.tr("Localizable", "refund_error.failed.description", fallback: "The refund request failed.")
    }
  }
  internal enum VerificationError {
    /// Transaction for productID: %s is unverified by the App Store. Verification error: %s.
    internal static func unverified(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "verification_error.unverified", p1, p2, fallback: "Transaction for productID: %s is unverified by the App Store. Verification error: %s.")
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
