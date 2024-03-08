//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductsView

struct ProductsView: View, IViewWrapper {
    // MARK: Properties

    @Environment(\.storeButton) var storeButton
    private let viewModel: ProductsViewModel

    // MARK: Initialization

    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
    }

    // MARK: View

    var body: some View {
        NavigationView {
            contentView
                .onAppear { viewModel.presenter.viewDidLoad() }
        }
    }

    // MARK: Private

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case let .products(products):
            VStack {
                List(Array(products), id: \.self) { product in
                    viewModel.productAssembly.assemble(storeProduct: product)
                }
                storeButtonView
            }
        case .error:
            StoreUnavaliableView()
        }
    }

    private var storeButtonView: some View {
        Group {
            ForEach(storeButton, id: \.self) { type in
                viewModel.storeButtonAssembly.assemble(storeButtonType: type)
            }
        }
    }
}
