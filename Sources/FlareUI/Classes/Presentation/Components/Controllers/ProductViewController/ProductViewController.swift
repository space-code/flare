//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit
import SwiftUI

// MARK: - ProductViewController

#if os(iOS)
    /// A view controller for displaying a product.
    ///
    /// A `ProductViewController` shows information about an in-app purchase product, including its localized name, description,
    /// and price, and displays a purchase button.
    ///
    /// You create a product view controller by providing a product identifier to load from the App Store. If you provide a product
    /// identifier,
    /// the view controller loads the product’s information from the App Store automatically, and updates the view when the product is
    /// available.
    ///
    /// You can customize the product view’s appearance using the standard styles, including the ``LargeProductStyle`` and
    /// ``CompactProductStyle`` styles. Apply the style using the ``ProductViewController/productStyle``.
    ///
    /// You can also create your own custom styles by creating styles that conform to the ``IProductStyle`` protocol.
    @available(iOS 13.0, macOS 11.0, *)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public final class ProductViewController: ViewController {
        // MARK: - Properties

        private lazy var viewModel = ProductViewControllerViewModel()

        private lazy var productView: HostingController<some View> = {
            let view = ProductView(id: self.id)
                .onInAppPurchaseCompletion(completion: viewModel.onInAppPurchaseCompletion)
                .inAppPurchaseOptions(viewModel.inAppPurchaseOptions)
                .productViewStyle(viewModel.productStyle)

            return BaseHostingController(rootView: view)
        }()

        private let id: String

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

        /// Initialize a `ProductViewController` for the given id.
        ///
        /// - Parameter id: The product id.
        public init(id: String) {
            self.id = id
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
            self.add(productView)
        }
    }

    // MARK: - Environments

    public extension ProductViewController {
        /// Configures the in-app purchase options.
        ///
        /// - Parameter options: A closure that returns the purchase options for a given store product.
        @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
        func inAppPurchaseOptions(_ options: ((StoreProduct) -> Set<Product.PurchaseOption>?)?) {
            viewModel.inAppPurchaseOptions = { PurchaseOptions(options: options?($0) ?? []) }
        }
    }
#endif
