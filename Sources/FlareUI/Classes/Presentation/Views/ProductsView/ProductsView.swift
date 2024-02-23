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
        contentView
            .onAppear { viewModel.presenter.viewDidLoad() }
    }

    // MARK: Private

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case let .productIDs(ids):
            List(Array(ids), id: \.self) { id in
                viewModel.productAssembly.assemble(id: id)
            }
        }
    }
}
