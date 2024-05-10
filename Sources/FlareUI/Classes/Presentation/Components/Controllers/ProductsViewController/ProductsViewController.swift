//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit
import SwiftUI
#if canImport(UIKit)
    import UIKit
#elseif canImport(Cocoa)
    import Cocoa
#endif

// MARK: - ProductsViewController

#if os(iOS) || os(macOS)
    /// A view for displaying multiple products.
    ///
    /// A `ProductsViewController` display a collection of in-app purchase products, iincluding their localized names,
    /// descriptions, prices, and displays a purchase button.
    ///
    /// ## Customize the products view controller ##
    ///
    /// You can customize the controller by displaying additional buttons, and applying styles.
    ///
    /// You can change the product style using ``ProductsViewController/productStyle``.
    @available(iOS 13.0, macOS 11.0, *)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public final class ProductsViewController: ViewController {
        // MARK: - Properties

        private lazy var viewModel = ProductsViewControllerViewModel()

        private lazy var productsView: HostingController<some View> = {
            let view = ProductsView(ids: self.ids)
                .onInAppPurchaseCompletion(completion: viewModel.onInAppPurchaseCompletion)
                .storeButton(.visible, types: viewModel.visibleStoreButtons)
                .storeButton(.hidden, types: viewModel.hiddenStoreButtons)
                .inAppPurchaseOptions(viewModel.inAppPurchaseOptions)
                .productViewStyle(viewModel.productStyle)

            return BaseHostingController(rootView: view)
        }()

        private let ids: any Collection<String>

        /// A completion handler for in-app purchase events.
        public var onInAppPurchaseCompletion: PurchaseCompletionHandler? {
            didSet {
                viewModel.onInAppPurchaseCompletion = onInAppPurchaseCompletion
            }
        }

        /// The product style.
        public var productStyle: any IProductStyle = CompactProductStyle() {
            didSet {
                viewModel.productStyle = AnyProductStyle(style: productStyle)
            }
        }

        // MARK: Initialization

        /// Initialize a `ProductsViewController` for the given IDs.
        ///
        /// - Parameter ids: The products IDs.
        public init(ids: some Collection<String>) {
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
            self.add(productsView)
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

    @available(iOS 13.0, macOS 11.0, *)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public extension ProductsViewController {
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
