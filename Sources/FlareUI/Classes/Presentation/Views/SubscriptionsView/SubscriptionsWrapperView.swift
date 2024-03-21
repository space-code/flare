//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct SubscriptionsWrapperView: View, IViewWrapper {
    // MARK: Propertirs

    @Environment(\.purchaseCompletion) private var purchaseCompletion
    @Environment(\.purchaseOptions) private var purchaseOptions
    @Environment(\.subscriptionMarketingContent) private var subscriptionMarketingContent
    @Environment(\.subscriptionBackground) private var subscriptionBackground

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
            VStack(spacing: .zero) {
                productsView(products: products)
                    .onAppear { selectedProduct = products.first(where: { $0.id == viewModel.selectedProductID }) }

                #if os(iOS)
                    toolbarView
                #endif
            }
            .background(subscriptionBackground.edgesIgnoringSafeArea(.all))
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
                #if os(tvOS)
                    progressView
                #else
                    progressView
                        .controlSize(.large)
                #endif
            } else {
                ActivityIndicatorView(isAnimating: .constant(true), style: .large)
            }

            Text(L10n.Subscription.Loading.message)
                .font(.subheadline)
                .foregroundColor(Palette.systemGray)
        }
    }

    private func productsView(products: [SubscriptionView.ViewModel]) -> some View {
        VStack(alignment: .center, spacing: .zero) {
            GeometryReader { geo in
                ScrollView {
                    #if os(iOS)
                        SubscriptionHeaderView(topInset: geo.safeAreaInsets.top)
                    #endif

                    VStack {
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
                    .padding(.bottom)
                }
                .edgesIgnoringSafeArea(subscriptionMarketingContent != nil ? .top : [])
            }
        }
    }

    @available(iOS 13.0, *)
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    private var toolbarView: some View {
        selectedProduct.map { product in
            SubscriptionToolbarView(
                viewModel: .init(id: product.id, title: product.title, price: product.price, description: product.description),
                action: {
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
            )
        }
    }

    @available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *)
    private var progressView: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
}
