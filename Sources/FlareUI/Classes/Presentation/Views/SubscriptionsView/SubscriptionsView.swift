//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A view for displaying subscriptions.
///
/// A `SubscriptionsView` displays localized information about auto-renewable subscriptions,
/// including their localized names, descriptios, prices, and a purchase button.
///
/// ## Provide a background and a decorative icon ##
///
/// The subscription view draws a default background by default. You can add a background as follows:
///  - To set the container background of the subscriptions view using a color, use the ``SwiftUI/View/subscriptionBackground(_:)``
///  - To set the header backgroubd of the subscriptions view using a color, use the
/// ``SwiftUI/View/subscriptionHeaderContentBackground(_:)``
///  - To set a marketing header content, use the ``SwiftUI/View/subscriptionMarketingContent(view:)``
///
/// ## Provide a custom buttons appearance ##
///
/// The `SubscriptionsView` can display subscription buttons in various forms. You can change the buttons appearance using
/// ``SwiftUI/View/subscriptionButtonLabel(_:)`` or you can change the form of buttons using ``SwiftUI/View/subscriptionControlStyle(_:)``.
///
/// ## Handle purchase events ##
///
/// The subscription view provides an easy way to handle purchase events as follows:
///  - To handle the completion of a purchase event, use the ``SwiftUI/View/onInAppPurchaseCompletion(completion:)``
///  - To pass an additional parameters to a purchase event, use the ``SwiftUI/View/inAppPurchaseOptions(_:)``
///
/// ## Customizing Behavior ##
///
/// The `SubscriptionsView` draws a pin if the subscription is active. You can customize this behavior by passing a custom
/// ``ISubscriptionStatusVerifier`` inside ``UIConfiguration`` to ``FlareUI``.
///
/// ## Add terms of service and privacy policy ##
///
/// The `SubscriptionView` can display buttons for terms of service and privacy policy.  You can provide either URLs or custom views with
/// this information. You can do this using modifiers
/// - ``SwiftUI/View/subscriptionTermsOfServiceURL(_:)``
/// - ``SwiftUI/View/subscriptionTermsOfServiceDestination(content:)``
/// - ``SwiftUI/View/subscriptionPrivacyPolicyURL(_:)``
/// - ``SwiftUI/View/subscriptionPrivacyPolicyDestination(content:)``
///
/// ## Add auxiliary buttons ##
///
/// The `SubscriptionView` can display auxiliary buttons like Restore Purchases. You can specify button visibility within the subscription
/// view using ``SwiftUI/View/storeButton(_:types:)-1eqh``.
///
/// # Example #
///
/// ```swift
/// struct PaywallView: View {
///     var body: some View {
///         SubscriptionsView(ids: ["com.company.app.subscription"])
///     }
/// }
/// ```
@available(iOS 13.0, tvOS 13.0, macOS 11.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct SubscriptionsView: View {
    // MARK: Properties

    /// The presentation assembly for creating views.
    private let presentationAssembly = PresentationAssembly()

    /// The IDs of the subscriptions to display.
    private let ids: any Collection<String>

    // MARK: Initialization

    /// Initializes the subscriptions view with the given IDs.
    ///
    /// - Parameter ids: The IDs of the subscriptions to display.
    public init(ids: some Collection<String>) {
        self.ids = ids
    }

    // MARK: View

    public var body: some View {
        presentationAssembly.subscritpionsViewAssembly.assemble(ids: ids)
    }
}
