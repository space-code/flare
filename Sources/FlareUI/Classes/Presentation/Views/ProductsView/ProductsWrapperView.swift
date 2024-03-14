//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductsWrapperView

struct ProductsWrapperView: View, IViewWrapper {
    // MARK: Properties

    @Environment(\.productViewStyle) var productViewStyle
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
        case let .loading(numberOfItems):
            contentView {
                ForEach(0 ..< numberOfItems, id: \.self) { _ in
                    productViewStyle.makeBody(configuration: .init(state: .loading))
                }
            }
        case let .products(products):
            contentView {
                ForEach(Array(products), id: \.self) { product in
                    productViewAssembly.map { $0.assemble(storeProduct: product) }
                }
            }
        case .error:
            StoreUnavaliableView(productType: .product)
        }
    }

    private var storeButtonView: some View {
        ForEach(storeButton, id: \.self) { type in
            storeButtonAssembly.map { $0.assemble(storeButtonType: type) }
        }
    }

    private func contentView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .center) {
            ScrollView {
                content()
                    .padding(.horizontal)
            }.animation(nil, value: UUID())
            Spacer()
            storeButtonView
        }
    }
}
