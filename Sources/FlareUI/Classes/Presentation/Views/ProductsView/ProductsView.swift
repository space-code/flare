//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct ProductsView: View, IViewWrapper {
    // MARK: Properties

    private let viewModel: ProductsViewModel

    // MARK: Initialization

    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
    }

    // MARK: View

    var body: some View {
        contentView
            .onAppear { viewModel.presenter.viewDidLoad() }
    }

    // MARK: Private

    private var contentView: some View {
        List(viewModel.products) { product in
            ProductView(viewModel: product) {
                Task {
                    await viewModel.presenter.purchase(productID: product.id)
                }
            }
        }
    }
}
