//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit
import SwiftUI

// MARK: - SubscriptionsViewController

#if os(iOS) || os(macOS)
    /// A view for displaying subscriptions.
    ///
    /// A `SubscriptionsViewController` displays localized information about auto-renewable subscriptions,
    /// including their localized names, descriptios, prices, and a purchase button.
    ///
    /// ## Provide a background and a decorative icon ##
    ///
    /// The subscription view controller draws a default background by default. You can add a background as follows:
    ///  - To set the container background of the subscriptions view using a color, use the
    /// ``SubscriptionsViewController/subscriptionBackgroundColor``
    ///  - To set the header backgroubd of the subscriptions view controller using a color, use the
    /// ``SubscriptionsViewController/subscriptionHeaderContentBackground``
    ///  - To set a marketing header content, use the ``SubscriptionsViewController/subscriptionMarketingContnentView``
    ///
    /// ## Provide a custom buttons appearance ##
    ///
    /// The `SubscriptionsViewController` can display subscription buttons in various forms. You can change the buttons appearance using
    /// ``SubscriptionsViewController/subscriptionButtonLabelStyle`` or you can change the form of buttons using
    /// ``SubscriptionsViewController/subscriptionControlStyle``.
    ///
    /// ## Handle purchase events ##
    ///
    /// The subscriptions view controller provides an easy way to handle purchase events as follows:
    ///  - To handle the completion of a purchase event, use the ``SubscriptionsViewController/onInAppPurchaseCompletion``
    ///  - To pass an additional parameters to a purchase event, use the ``SubscriptionsViewController/inAppPurchaseOptions(_:)``
    ///
    /// ## Customizing Behavior ##
    ///
    /// The `SubscriptionsViewController` draws a pin if the subscription is active. You can customize this behavior by passing a custom
    /// ``ISubscriptionStatusVerifier`` inside ``UIConfiguration`` to ``FlareUI``.
    ///
    /// ## Add terms of service and privacy policy ##
    ///
    /// The `SubscriptionsViewController` can display buttons for terms of service and privacy policy.  You can provide either URLs or
    /// custom views with
    /// this information. You can do this using modifiers
    /// - ``SubscriptionsViewController/subscriptionTermsOfServiceURL``
    /// - ``SubscriptionsViewController/subscriptionTermsOfServiceView``
    /// - ``SubscriptionsViewController/subscriptionPrivacyPolicyURL``
    /// - ``SubscriptionsViewController/subscriptionPrivacyPolicyView``
    ///
    /// ## Add auxiliary buttons ##
    ///
    /// The `SubscriptionsViewController` can display auxiliary buttons like Restore Purchases. You can specify button visibility within the
    /// subscription
    /// view using ``SubscriptionsViewController/storeButton(_:types:)``.
    @available(iOS 13.0, macOS 11.0, *)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public final class SubscriptionsViewController: ViewController {
        // MARK: Properties

        private lazy var viewModel = SubscriptionsViewControllerViewModel()

        private lazy var subscriptionsView: HostingController<some View> = {
            let view = SubscriptionsView(ids: self.ids)
                .onInAppPurchaseCompletion(completion: viewModel.onInAppPurchaseCompletion)
                .inAppPurchaseOptions(viewModel.inAppPurchaseOptions)
                .subscriptionControlStyle(viewModel.subscriptionControlStyle)
                .subscriptionBackground(viewModel.subscriptionBackgroundColor)
                .subscriptionViewTint(viewModel.subscriptionViewTintColor)
                .subscriptionButtonLabel(viewModel.subscriptionButtonLabelStyle)
                .storeButton(.visible, types: viewModel.visibleStoreButtons)
                .storeButton(.hidden, types: viewModel.hiddenStoreButtons)
                .subscriptionMarketingContent { viewModel.marketingContent }
            #if os(iOS) || os(tvOS)
                .subscriptionHeaderContentBackground(viewModel.subscriptionHeaderContentBackground)
            #endif
            #if os(iOS)
            .subscriptionPrivacyPolicyURL(viewModel.subscriptionPrivacyPolicyURL)
            .subscriptionTermsOfServiceURL(viewModel.subscriptionTermsOfServiceURL)
            #endif

            return BaseHostingController(rootView: view)
        }()

        private let ids: any Collection<String>

        /// A completion handler for in-app purchase events.
        public var onInAppPurchaseCompletion: PurchaseCompletionHandler? {
            didSet {
                viewModel.onInAppPurchaseCompletion = onInAppPurchaseCompletion
            }
        }

        /// The style of the subscription control.
        public var subscriptionControlStyle: any ISubscriptionControlStyle = AutomaticSubscriptionControlStyle() {
            didSet {
                viewModel.subscriptionControlStyle = AnySubscriptionControlStyle(style: subscriptionControlStyle)
            }
        }

        /// The background color of the subscription view.
        public var subscriptionBackgroundColor: ColorRepresentation = .clear {
            didSet {
                viewModel.subscriptionBackgroundColor = Color(subscriptionBackgroundColor)
            }
        }

        /// The tint color of the subscription view.
        public var subscriptionViewTintColor: ColorRepresentation = .blue {
            didSet {
                viewModel.subscriptionViewTintColor = Color(subscriptionViewTintColor)
            }
        }

        /// The style of the subscription button label.
        public var subscriptionButtonLabelStyle: SubscriptionStoreButtonLabel = .action {
            didSet {
                viewModel.subscriptionButtonLabelStyle = subscriptionButtonLabelStyle
            }
        }

        /// The view for marketing content.
        public var subscriptionMarketingContnentView: ViewRepresentation? {
            didSet {
                guard let subscriptionMarketingContnentView else {
                    viewModel.marketingContent = nil
                    return
                }
                viewModel.marketingContent = SUIViewWrapper(
                    view: subscriptionMarketingContnentView
                )
                .eraseToAnyView()
            }
        }

        #if os(iOS) || os(tvOS)
            /// The background color of the subscription header content.
            public var subscriptionHeaderContentBackground: ColorRepresentation = .clear {
                didSet {
                    viewModel.subscriptionHeaderContentBackground = Color(subscriptionHeaderContentBackground)
                }
            }
        #endif

        #if os(iOS)
            /// The URL for the privacy policy.
            public var subscriptionPrivacyPolicyURL: URL? {
                didSet {
                    viewModel.subscriptionPrivacyPolicyURL = subscriptionPrivacyPolicyURL
                }
            }

            /// The URL for the terms of service.
            public var subscriptionTermsOfServiceURL: URL? {
                didSet {
                    viewModel.subscriptionTermsOfServiceURL = subscriptionTermsOfServiceURL
                }
            }
        #endif

        /// The view for the privacy policy.
        public var subscriptionPrivacyPolicyView: ViewRepresentation? {
            didSet {
                guard let subscriptionPrivacyPolicyView else {
                    self.viewModel.subscriptionPrivacyPolicyView = nil
                    return
                }
                viewModel.subscriptionPrivacyPolicyView = SUIViewWrapper(
                    view: subscriptionPrivacyPolicyView
                ).eraseToAnyView()
            }
        }

        /// The view for the terms of service.
        public var subscriptionTermsOfServiceView: ViewRepresentation? {
            didSet {
                guard let subscriptionTermsOfServiceView else {
                    self.viewModel.subscriptionTermsOfServiceView = nil
                    return
                }
                viewModel.subscriptionTermsOfServiceView = SUIViewWrapper(
                    view: subscriptionTermsOfServiceView
                ).eraseToAnyView()
            }
        }

        // MARK: Initialization

        /// Initialize a `SubscriptionsViewController` for the given IDs.
        ///
        /// - Parameter ids: The subscriptions IDs.
        public init(ids: any Collection<String>) {
            self.ids = ids
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        public required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: Life Cycle

        override public func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
        }

        // MARK: Private

        private func setupUI() {
            #if os(iOS) || os(tvOS)
                self.view.backgroundColor = Asset.Colors.systemBackground.color
            #endif
            self.add(subscriptionsView)
        }

        private func updateStoreButtons(
            _ buttons: inout [StoreButtonType],
            add newButtons: [StoreButtonType]
        ) {
            buttons += newButtons
            buttons = buttons.removingDuplicates()
        }
    }

    // MARK: - Environments

    /// Extension for configuring store button visibility.
    @available(iOS 13.0, macOS 11.0, tvOS 13.0, *)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public extension SubscriptionsViewController {
        /// Configures the visibility of store buttons.
        ///
        /// - Parameters:
        ///   - visibility: The visibility of the store buttons.
        ///   - types: The types of store buttons to configure.
        func storeButton(_ visibility: StoreButtonVisibility, types: [StoreButtonType]) {
            switch visibility {
            case .visible:
                updateStoreButtons(&viewModel.visibleStoreButtons, add: types)
                viewModel.hiddenStoreButtons.removeAll { types.contains($0) }
            case .hidden:
                updateStoreButtons(&viewModel.hiddenStoreButtons, add: types)
                viewModel.visibleStoreButtons.removeAll { types.contains($0) }
            }
        }

        /// Configures the in-app purchase options.
        ///
        /// - Parameter options: A closure that returns the purchase options for a given store product.
        @available(iOS 15.0, tvOS 15.0, macOS 12.0, *)
        func inAppPurchaseOptions(_ options: ((StoreProduct) -> Set<Product.PurchaseOption>?)?) {
            viewModel.inAppPurchaseOptions = { PurchaseOptions(options: options?($0) ?? []) }
        }
    }

#endif
