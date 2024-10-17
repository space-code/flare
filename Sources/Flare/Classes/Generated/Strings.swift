//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// MARK: - L10n

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
enum L10n {
    enum Error {
        enum FailedToDecodeSignature {
            /// Decoding the signature has failed. The signature: %s
            static func description(_ p1: UnsafePointer<CChar>) -> String {
                L10n.tr(
                    "Localizable",
                    "error.failed_to_decode_signature.description",
                    p1,
                    fallback: "Decoding the signature has failed. The signature: %s"
                )
            }
        }

        enum InvalidProductIds {
            /// Invalid product IDs: %@
            static func description(_ p1: Any) -> String {
                L10n.tr("Localizable", "error.invalid_product_ids.description", String(describing: p1), fallback: "Invalid product IDs: %@")
            }
        }

        enum PaymentCancelled {
            /// The payment was canceled by the user.
            static let description = L10n.tr(
                "Localizable",
                "error.payment_cancelled.description",
                fallback: "The payment was canceled by the user."
            )
        }

        enum PaymentDefferred {
            /// The purchase is pending, and requires action from the customer.
            static let description = L10n.tr(
                "Localizable",
                "error.payment_defferred.description",
                fallback: "The purchase is pending, and requires action from the customer."
            )
        }

        enum PaymentNotAllowed {
            /// The current user is not eligible to make payments.
            static let description = L10n.tr(
                "Localizable",
                "error.payment_not_allowed.description",
                fallback: "The current user is not eligible to make payments."
            )
            /// The payment card may have purchase restrictions, such as set limits or unavailability for online shopping.
            static let failureReason = L10n.tr(
                "Localizable",
                "error.payment_not_allowed.failure_reason",
                fallback: "The payment card may have purchase restrictions, such as set limits or unavailability for online shopping."
            )
            /// Please check the payment card purchase restrictions.
            static let recoverySuggestion = L10n.tr(
                "Localizable",
                "error.payment_not_allowed.recovery_suggestion",
                fallback: "Please check the payment card purchase restrictions."
            )
        }

        enum Receipt {
            /// The receipt could not be found.
            static let description = L10n.tr("Localizable", "error.receipt.description", fallback: "The receipt could not be found.")
        }

        enum Refund {
            /// The error occurred during the refund: %s
            static func description(_ p1: UnsafePointer<CChar>) -> String {
                L10n.tr("Localizable", "error.refund.description", p1, fallback: "The error occurred during the refund: %s")
            }
        }

        enum StoreProductNotAvailable {
            /// The store product is currently unavailable.
            static let description = L10n.tr(
                "Localizable",
                "error.store_product_not_available.description",
                fallback: "The store product is currently unavailable."
            )
            /// Make sure to create a product with the given identifier in App Store Connect.
            static let recoverySuggestion = L10n.tr(
                "Localizable",
                "error.store_product_not_available.recovery_suggestion",
                fallback: "Make sure to create a product with the given identifier in App Store Connect."
            )
        }

        enum TransactionNotFound {
            /// Transaction for productID: %s couldn't be found.
            static func description(_ p1: UnsafePointer<CChar>) -> String {
                L10n.tr(
                    "Localizable",
                    "error.transaction_not_found.description",
                    p1,
                    fallback: "Transaction for productID: %s couldn't be found."
                )
            }
        }

        enum Unknown {
            /// The SKPayment returned unknown error.
            static let description = L10n.tr("Localizable", "error.unknown.description", fallback: "The SKPayment returned unknown error.")
        }

        enum Verification {
            /// The verification has failed with the following error: %s
            static func description(_ p1: UnsafePointer<CChar>) -> String {
                L10n.tr(
                    "Localizable",
                    "error.verification.description",
                    p1,
                    fallback: "The verification has failed with the following error: %s"
                )
            }
        }

        enum With {
            /// The error occurred: %s
            static func description(_ p1: UnsafePointer<CChar>) -> String {
                L10n.tr("Localizable", "error.with.description", p1, fallback: "The error occurred: %s")
            }
        }
    }

    enum Flare {
        /// Flare configured with configuration:
        /// %@
        static func initWithConfiguration(_ p1: Any) -> String {
            L10n.tr(
                "Localizable",
                "flare.init_with_configuration",
                String(describing: p1),
                fallback: "Flare configured with configuration:\n%@"
            )
        }
    }

    enum Payment {
        /// Adding payment for product: %s. %i transactions already in the queue
        static func paymentQueueAddingPayment(_ p1: UnsafePointer<CChar>, _ p2: Int) -> String {
            L10n.tr(
                "Localizable",
                "payment.payment_queue_adding_payment",
                p1,
                p2,
                fallback: "Adding payment for product: %s. %i transactions already in the queue"
            )
        }
    }

    enum Products {
        /// Requested products %@ not found.
        static func requestedProductsNotFound(_ p1: Any) -> String {
            L10n.tr(
                "Localizable",
                "products.requested_products_not_found",
                String(describing: p1),
                fallback: "Requested products %@ not found."
            )
        }

        /// Requested products %@ have been received
        static func requestedProductsReceived(_ p1: Any) -> String {
            L10n.tr(
                "Localizable",
                "products.requested_products_received",
                String(describing: p1),
                fallback: "Requested products %@ have been received"
            )
        }
    }

    enum Purchase {
        /// This device is not able or allowed to make payments.
        static let cannotPurcaseProduct = L10n.tr(
            "Localizable",
            "purchase.cannot_purcase_product",
            fallback: "This device is not able or allowed to make payments."
        )
        /// An error occurred while listening for transactions: %s
        static func errorUpdatingTransaction(_ p1: UnsafePointer<CChar>) -> String {
            L10n.tr(
                "Localizable",
                "purchase.error_updating_transaction",
                p1,
                fallback: "An error occurred while listening for transactions: %s"
            )
        }

        /// Finishing transaction %s for product identifier: %s
        static func finishingTransaction(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
            L10n.tr(
                "Localizable",
                "purchase.finishing_transaction",
                p1,
                p2,
                fallback: "Finishing transaction %s for product identifier: %s"
            )
        }

        /// Product purchase for %s failed with error: %s
        static func productPurchaseFailed(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
            L10n.tr("Localizable", "purchase.product_purchase_failed", p1, p2, fallback: "Product purchase for %s failed with error: %s")
        }

        /// Purchased product: %s
        static func purchasedProduct(_ p1: UnsafePointer<CChar>) -> String {
            L10n.tr("Localizable", "purchase.purchased_product", p1, fallback: "Purchased product: %s")
        }

        /// Purchasing product: %s
        static func purchasingProduct(_ p1: UnsafePointer<CChar>) -> String {
            L10n.tr("Localizable", "purchase.purchasing_product", p1, fallback: "Purchasing product: %s")
        }

        /// Purchasing product %s with offer %s
        static func purchasingProductWithOffer(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
            L10n.tr("Localizable", "purchase.purchasing_product_with_offer", p1, p2, fallback: "Purchasing product %s with offer %s")
        }

        /// Transaction for productID: %s not found.
        static func transactionNotFound(_ p1: UnsafePointer<CChar>) -> String {
            L10n.tr("Localizable", "purchase.transaction_not_found", p1, fallback: "Transaction for productID: %s not found.")
        }

        /// Transaction for productID: %s is unverified by the App Store. Verification error: %s.
        static func transactionUnverified(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
            L10n.tr(
                "Localizable",
                "purchase.transaction_unverified",
                p1,
                p2,
                fallback: "Transaction for productID: %s is unverified by the App Store. Verification error: %s."
            )
        }
    }

    enum Receipt {
        /// Refreshed receipt. Request id: %s.
        static func refreshedReceipt(_ p1: UnsafePointer<CChar>) -> String {
            L10n.tr("Localizable", "receipt.refreshed_receipt", p1, fallback: "Refreshed receipt. Request id: %s.")
        }

        /// Refreshing receipt. Request id: %s.
        static func refreshingReceipt(_ p1: UnsafePointer<CChar>) -> String {
            L10n.tr("Localizable", "receipt.refreshing_receipt", p1, fallback: "Refreshing receipt. Request id: %s.")
        }

        /// Refreshing receipt failed with error: %s. Request id: %s.
        static func refreshingReceiptFailed(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
            L10n.tr(
                "Localizable",
                "receipt.refreshing_receipt_failed",
                p1,
                p2,
                fallback: "Refreshing receipt failed with error: %s. Request id: %s."
            )
        }
    }

    enum Redeem {
        /// Presenting code redemption sheet.
        static let presentingCodeRedemptionSheet = L10n.tr(
            "Localizable",
            "redeem.presenting_code_redemption_sheet",
            fallback: "Presenting code redemption sheet."
        )
        /// Presenting offer code redeem sheet
        static let presentingOfferCodeRedeemSheet = L10n.tr(
            "Localizable",
            "redeem.presenting_offer_code_redeem_sheet",
            fallback: "Presenting offer code redeem sheet"
        )
        /// Unable to present offer code redeem sheet due to unexpected error: %s
        static func unableToPresentOfferCodeRedeemSheet(_ p1: UnsafePointer<CChar>) -> String {
            L10n.tr(
                "Localizable",
                "redeem.unable_to_present_offer_code_redeem_sheet",
                p1,
                fallback: "Unable to present offer code redeem sheet due to unexpected error: %s"
            )
        }
    }

    enum Refund {
        /// Refund has already requested for this product: %s
        static func duplicateRefundRequest(_ p1: UnsafePointer<CChar>) -> String {
            L10n.tr("Localizable", "refund.duplicate_refund_request", p1, fallback: "Refund has already requested for this product: %s")
        }

        /// Refund request submission failed: %s
        static func failedRefundRequest(_ p1: UnsafePointer<CChar>) -> String {
            L10n.tr("Localizable", "refund.failed_refund_request", p1, fallback: "Refund request submission failed: %s")
        }
    }

    enum RefundError {
        enum DuplicateRequest {
            /// The request has been duplicated.
            static let description = L10n.tr(
                "Localizable",
                "refund_error.duplicate_request.description",
                fallback: "The request has been duplicated."
            )
        }

        enum Failed {
            /// The refund request failed.
            static let description = L10n.tr("Localizable", "refund_error.failed.description", fallback: "The refund request failed.")
        }
    }

    enum VerificationError {
        /// Transaction for productID: %s is unverified by the App Store. Verification error: %s.
        static func unverified(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
            L10n.tr(
                "Localizable",
                "verification_error.unverified",
                p1,
                p2,
                fallback: "Transaction for productID: %s is unverified by the App Store. Verification error: %s."
            )
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

// MARK: - BundleToken

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
