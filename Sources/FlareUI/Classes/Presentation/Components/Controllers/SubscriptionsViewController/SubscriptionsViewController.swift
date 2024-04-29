//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit
import SwiftUI

// MARK: - SubscriptionsViewController

#if os(iOS)
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

        public var onInAppPurchaseCompletion: PurchaseCompletionHandler? {
            didSet {
                viewModel.onInAppPurchaseCompletion = onInAppPurchaseCompletion
            }
        }

        public var subscriptionControlStyle: any ISubscriptionControlStyle = AutomaticSubscriptionControlStyle() {
            didSet {
                viewModel.subscriptionControlStyle = AnySubscriptionControlStyle(style: subscriptionControlStyle)
            }
        }

        public var subscriptionBackgroundColor: ColorRepresentation = .clear {
            didSet {
                viewModel.subscriptionBackgroundColor = Color(subscriptionBackgroundColor)
            }
        }

        public var subscriptionViewTintColor: ColorRepresentation = .blue {
            didSet {
                viewModel.subscriptionViewTintColor = Color(subscriptionViewTintColor)
            }
        }

        public var subscriptionButtonLabelStyle: SubscriptionStoreButtonLabel = .action {
            didSet {
                viewModel.subscriptionButtonLabelStyle = subscriptionButtonLabelStyle
            }
        }

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
            public var subscriptionHeaderContentBackground: ColorRepresentation = .clear {
                didSet {
                    viewModel.subscriptionHeaderContentBackground = Color(subscriptionHeaderContentBackground)
                }
            }
        #endif

        #if os(iOS)
            public var subscriptionPrivacyPolicyURL: URL? {
                didSet {
                    viewModel.subscriptionPrivacyPolicyURL = subscriptionPrivacyPolicyURL
                }
            }

            public var subscriptionTermsOfServiceURL: URL? {
                didSet {
                    viewModel.subscriptionTermsOfServiceURL = subscriptionTermsOfServiceURL
                }
            }
        #endif

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

    @available(iOS 13.0, macOS 11.0, tvOS 13.0, *)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public extension SubscriptionsViewController {
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

        @available(iOS 15.0, tvOS 15.0, macOS 12.0, *)
        func inAppPurchaseOptions(_ options: ((StoreProduct) -> Set<Product.PurchaseOption>?)?) {
            viewModel.inAppPurchaseOptions = { PurchaseOptions(options: options?($0) ?? []) }
        }
    }
#endif
