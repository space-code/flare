//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct SubscriptionsWrapperView: View, IViewWrapper {
    // MARK: Propertirs

    @Environment(\.storeButtonAssembly) var storeButtonAssembly
    @Environment(\.storeButton) var storeButton
    @Environment(\.purchaseCompletion) var purchaseCompletion
    @Environment(\.purchaseOptions) var purchaseOptions
    @Environment(\.subscriptionStoreButtonLabel) private var subscriptionStoreButtonLabel

    @State private var selectedProduct: SubscriptionView.ViewModel?
    @State private var error: Error?

    private let viewModel: SubscriptionsViewModel

    // MARK: Initialization

    init(viewModel: SubscriptionsViewModel) {
        self.viewModel = viewModel
    }

    // MARK: View

    var body: some View {
        contentView
            .onAppear { viewModel.presenter.viewDidLoad() }
            .errorAlert($error)
    }

    // MARK: Private

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case let .products(products):
            productsView(products: products)
                .onAppear { selectedProduct = products.first(where: { $0.id == viewModel.selectedProductID }) }
            bottomToolbar { purchaseButtonContainerView }
        case .error:
            StoreUnavaliableView(productType: .subscription)
        }
    }

    private var loadingView: some View {
        VStack(alignment: .center, spacing: 52) {
            if #available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *) {
                progressView
                    .scaleEffect(1.74)
            } else if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *) {
                progressView
                    .controlSize(.large)
            } else {
                ActivityIndicatorView(isAnimating: .constant(true), style: .large)
            }
            Text("Loading Subscriptions...")
                .font(.subheadline)
                .foregroundColor(Palette.systemGray)
        }
    }

    private func productsView(products: [SubscriptionView.ViewModel]) -> some View {
        VStack(alignment: .center) {
            ScrollView {
                ForEach(products) { viewModel in
                    SubscriptionView(
                        viewModel: viewModel,
                        isSelected: .constant(viewModel.id == self.viewModel.selectedProductID)
                    ) {
                        self.selectedProduct = viewModel
                        self.viewModel.presenter.selectProduct(with: viewModel.id)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }

    @available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *)
    private var progressView: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }

    private var purchaseButton: some View {
        selectedProduct.map { product in
            SubscribeButton(
                viewModel: .init(
                    displayName: product.title,
                    price: L10n.Subscriptions.Renewable.subscriptionDescription(product.price)
                )
            ) {
                guard let product = viewModel.presenter.product(withID: product.id) else { return }

                Task {
                    do {
                        let transaction = try await self.viewModel.presenter.subscribe(optionsHandler: purchaseOptions)
                        purchaseCompletion?(product, .success(transaction))
                    } catch {
                        if error.iap != .paymentCancelled {
                            self.error = error.iap
                            purchaseCompletion?(product, .failure(error))
                        }
                    }
                }
            }
        }
    }

    private var purchaseButtonContainerView: some View {
        VStack(spacing: 24.0) {
            subscriptionsDetailsView { purchaseButton }
            storeButtonView
        }
    }

    private func subscriptionsDetailsView(@ViewBuilder content: () -> some View) -> some View {
        VStack(spacing: 6.0) {
            if viewModel.numberOfProducts > 1, subscriptionStoreButtonLabel == .action {
                subscriptionsDetailsView
                    .foregroundColor(Palette.systemGray)
                    .font(.footnote)
                content()
            } else if viewModel.numberOfProducts == 1, subscriptionStoreButtonLabel == .action {
                content()
                subscriptionsDetailsView
                    .font(.subheadline)
            }
        }
    }

    private func bottomToolbar(@ViewBuilder content: () -> some View) -> some View {
        VStack {
            content()
        }
    }

    private var subscriptionsDetailsView: some View {
        selectedProduct.map {
            Text(L10n.Subscriptions.Renewable.subscriptionDescription($0.price))
        }
    }

    private var storeButtonView: some View {
        ForEach(storeButton, id: \.self) { type in
            storeButtonAssembly.map { $0.assemble(storeButtonType: type) }
        }
    }
}

//    .subscriptionStorePickerItemBackground(.thinMaterial)
// func onInAppPurchaseCompletion(perform: ((Product, Result<Product.PurchaseResult, any Error>) -> ())?) -> View
// func inAppPurchaseOptions(((Product) -> Set<Product.PurchaseOption>)?) -> View
// func subscriptionStoreControlIcon(icon: (Product, Product.SubscriptionInfo) -> some View) -> View
// func subscriptionStorePickerItemBackground(some ShapeStyle) -> View
// policy & terms of use
