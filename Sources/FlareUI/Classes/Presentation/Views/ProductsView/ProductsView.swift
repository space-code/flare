//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit
import SwiftUI

// MARK: - ProductsView

struct ProductsView: View, IViewWrapper {
    // MARK: Properties

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
            List(Array(products), id: \.self) { product in
                viewModel.productAssembly.assemble(storeProduct: product)
            }
        case .error:
            VStack {
                Text("Store Unavailable")
                    .font(.title)
                Text("No in-app purchases are availiable in the current storefront.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Palette.systemGray)
            }
            .padding()
        }
    }
}
