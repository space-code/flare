//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductsWrapperView

struct ProductsWrapperView: View, IViewWrapper {
    // MARK: Properties

    @Environment(\.storeButton) var storeButton
    @Environment(\.productViewAssembly) var productViewAssembly
    @Environment(\.storeButtonAssembly) var storeButtonAssembly

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
                    productViewAssembly.map { $0.assemble(storeProduct: product) }
                }
                .padding(.horizontal)
                Spacer()
                storeButtonView
            }
        case .error:
            StoreUnavaliableView()
        }
    }

    private var storeButtonView: some View {
        ForEach(storeButton, id: \.self) { type in
            storeButtonAssembly.map { $0.assemble(storeButtonType: type) }
        }
    }
}
