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
    enum Common {
        /// Privacy Policy
        static let privacyPolicy = L10n.tr("Localizable", "common.privacy_policy", fallback: "Privacy Policy")
        /// Terms of Service
        static let termsOfService = L10n.tr("Localizable", "common.terms_of_service", fallback: "Terms of Service")
        enum Subscription {
            enum Action {
                /// Subscribe
                static let subscribe = L10n.tr("Localizable", "common.subscription.action.subscribe", fallback: "Subscribe")
            }

            enum Status {
                /// Your current plan
                static let yourCurrentPlan = L10n.tr(
                    "Localizable",
                    "common.subscription.status.your_current_plan",
                    fallback: "Your current plan"
                )
                /// Your plan
                static let yourPlan = L10n.tr("Localizable", "common.subscription.status.your_plan", fallback: "Your plan")
            }
        }

        enum Words {
            /// and
            static let and = L10n.tr("Localizable", "common.words.and", fallback: "and")
        }
    }

    enum Error {
        enum Default {
            /// Error Occurred
            static let title = L10n.tr("Localizable", "error.default.title", fallback: "Error Occurred")
        }
    }

    enum Policies {
        enum Unavailable {
            enum PrivacyPolicy {
                /// Something went wrong. Try again.
                static let message = L10n.tr(
                    "Localizable",
                    "policies.unavailable.privacy_policy.message",
                    fallback: "Something went wrong. Try again."
                )
                /// Privacy Policy Unavailable
                static let title = L10n.tr(
                    "Localizable",
                    "policies.unavailable.privacy_policy.title",
                    fallback: "Privacy Policy Unavailable"
                )
            }

            enum TermsOfService {
                /// Something went wrong. Try again.
                static let message = L10n.tr(
                    "Localizable",
                    "policies.unavailable.terms_of_service.message",
                    fallback: "Something went wrong. Try again."
                )
                /// Terms of Service Unavailable
                static let title = L10n.tr(
                    "Localizable",
                    "policies.unavailable.terms_of_service.title",
                    fallback: "Terms of Service Unavailable"
                )
            }
        }
    }

    enum Product {
        /// Every %@
        static func priceDescription(_ p1: Any) -> String {
            L10n.tr("Localizable", "product.price_description", String(describing: p1), fallback: "Every %@")
        }

        enum Subscription {
            /// %@/%@
            static func price(_ p1: Any, _ p2: Any) -> String {
                L10n.tr("Localizable", "product.subscription.price", String(describing: p1), String(describing: p2), fallback: "%@/%@")
            }
        }
    }

    enum StoreButton {
        /// Restore Missing Purchases
        static let restorePurchases = L10n.tr("Localizable", "store_button.restore_purchases", fallback: "Restore Missing Purchases")
    }

    enum StoreUnavailable {
        /// Store Unavailable
        static let title = L10n.tr("Localizable", "store_unavailable.title", fallback: "Store Unavailable")
        enum Product {
            /// No in-app purchases are available in the current storefront.
            static let message = L10n.tr(
                "Localizable",
                "store_unavailable.product.message",
                fallback: "No in-app purchases are available in the current storefront."
            )
        }

        enum Subscription {
            /// The subscription is unavailable in the current storefront.
            static let message = L10n.tr(
                "Localizable",
                "store_unavailable.subscription.message",
                fallback: "The subscription is unavailable in the current storefront."
            )
        }
    }

    enum Subscription {
        enum Loading {
            /// Loading Subscriptions...
            static let message = L10n.tr("Localizable", "subscription.loading.message", fallback: "Loading Subscriptions...")
        }
    }

    enum Subscriptions {
        enum Renewable {
            /// Plan auto-renews for %@ until cancelled.
            static func subscriptionDescription(_ p1: Any) -> String {
                L10n.tr(
                    "Localizable",
                    "subscriptions.renewable.subscription_description",
                    String(describing: p1),
                    fallback: "Plan auto-renews for %@ until cancelled."
                )
            }

            /// Plan auto-renews for %@
            /// until cancelled.
            static func subscriptionDescriptionSeparated(_ p1: Any) -> String {
                L10n.tr(
                    "Localizable",
                    "subscriptions.renewable.subscription_description_separated",
                    String(describing: p1),
                    fallback: "Plan auto-renews for %@\nuntil cancelled."
                )
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
