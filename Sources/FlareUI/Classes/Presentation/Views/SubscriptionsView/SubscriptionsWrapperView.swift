//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct SubscriptionsWrapperView: View, IViewWrapper {
    // MARK: Propertirs

    @Environment(\.subscriptionsWrapperViewStyle) private var subscriptionsWrapperViewStyle

    @Environment(\.purchaseCompletion) private var purchaseCompletion
    @Environment(\.purchaseOptions) private var purchaseOptions
    @Environment(\.subscriptionBackground) private var subscriptionBackground
    @Environment(\.subscriptionControlStyle) private var subscriptionControlStyle
    @Environment(\.storeButtonsAssembly) private var storeButtonsAssembly
    @Environment(\.storeButton) private var storeButton

    @State private var selectedProduct: SubscriptionView.ViewModel?
    @State private var error: Error?

    private var isButtonsStyle: Bool {
        subscriptionControlStyle.style is ButtonSubscriptionStoreControlStyle
    }

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
            LoadingView()
        case let .products(products):
            VStack(spacing: .zero) {
                productsView(products: products)
                    .onAppear { selectedProduct = products.first(where: { $0.id == viewModel.selectedProductID }) }

                #if os(iOS)
                    if !isButtonsStyle {
                        toolbarView
                    }
                #else
                    if storeButton.contains(.policies) {
                        storeButtonsAssembly?.assemble(storeButtonType: .policies)
                    }
                #endif
            }
            .background(subscriptionBackground.edgesIgnoringSafeArea(.all))
        case .error:
            StoreUnavaliableView(productType: .subscription)
        }
    }

    private func productsView(products: [SubscriptionView.ViewModel]) -> some View {
        subscriptionsWrapperViewStyle.makeBody(
            configuration: .init(
                items: products,
                selectedID: selectedProduct?.id,
                action: { product in
                    if isButtonsStyle {
                        self.purchase(productID: product.id)
                    } else {
                        self.selectedProduct = product
                        self.viewModel.presenter.selectProduct(with: product.id)
                    }
                }
            )
        )
    }

    #if os(iOS)
        private var toolbarView: some View {
            selectedProduct.map { product in
                SubscriptionToolbarView(
                    viewModel: .init(
                        id: product.id,
                        title: product.title,
                        price: product.price,
                        description: product.description
                    ),
                    action: { self.purchase(productID: product.id) }
                )
            }
        }
    #endif

    private func purchase(productID: String) {
        guard let product = viewModel.presenter.product(withID: productID) else { return }

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
