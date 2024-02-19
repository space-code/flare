//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct ProductsView: View {
    // MARK: Properties

    private let presenter: IProductsPresenter

    // MARK: Initialization

    init(presenter: IProductsPresenter) {
        self.presenter = presenter
    }

    // MARK: View

    var body: some View {
        contentView
            .onAppear { presenter.viewDidLoad() }
    }

    // MARK: Private

    private var contentView: some View {
        List(presenter.viewModel.model.products) { product in
            ProductView(viewModel: product)
        }
    }
}
