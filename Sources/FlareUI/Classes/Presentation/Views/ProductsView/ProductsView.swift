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
        contentView
            .onAppear { viewModel.presenter.viewDidLoad() }
            .padding()
    }

    // MARK: Private

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case let .products(products):
            VStack(alignment: .center) {
                ForEach(Array(products), id: \.self) { product in
                    viewModel.productAssembly.assemble(storeProduct: product)
                }
                .padding()
                storeButtonView
            }
        case .error:
            StoreUnavaliableView()
        }
    }

    private var storeButtonView: some View {
        ForEach(storeButton, id: \.self) { type in
            viewModel.storeButtonAssembly.assemble(storeButtonType: type)
        }
    }
}
