//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductView

struct ProductView: View, IViewWrapper {
    // MARK: Properties

    @Environment(\.productViewStyle) var productViewStyle
    @State private var error: Error?

    private let viewModel: ProductViewModel

    // MARK: Initialization

    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
    }

    // MARK: View

    var body: some View {
        contentView
            .onLoad { viewModel.presenter.viewDidLoad() }
            .errorAlert($error)
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
                    purchase: purchase
                )
            )
        case let .error(error):
            productViewStyle.makeBody(configuration: .init(state: .error(error: error)))
        }
    }

    private func purchase() {
        Task { @MainActor in
            do {
                try await viewModel.presenter.purchase()
            } catch {
                self.error = error
            }
        }
    }
}
