//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductView

struct ProductView: View, IViewWrapper {
    // MARK: Properties

    @Environment(\.productViewStyle) var productViewStyle

    private let viewModel: ProductViewModel

    // MARK: Initialization

    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
    }

    // MARK: View

    var body: some View {
        contentView
            .onAppear { viewModel.presenter.viewDidLoad() }
    }

    // MARK: Private

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loading:
            productViewStyle.makeBody(configuration: .init(state: .loading))
        case let .product(storeProduct):
            productViewStyle.makeBody(
                configuration: .init(
                    state: .product(item: storeProduct),
                    purchase: { purchase(productID: storeProduct.productIdentifier) }
                )
            )
        }
    }

    private func purchase(productID: String) {
        Task {
            await viewModel.presenter.purchase(productID: productID)
        }
    }
}
