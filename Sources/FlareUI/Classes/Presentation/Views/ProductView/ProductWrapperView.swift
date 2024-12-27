//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - ProductWrapperView

struct ProductWrapperView: View, IViewWrapper {
    // MARK: Properties

    @Environment(\.productViewStyle) var productViewStyle
    @Environment(\.purchaseCompletion) var purchaseCompletion
    @Environment(\.purchaseOptions) var purchaseOptions

    @State private var error: Error?
    @State private var isExecuted = false

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
                    purchase: { Task { await self.purchase() } }
                )
            )
        case let .error(error):
            productViewStyle.makeBody(configuration: .init(state: .error(error: error)))
        }
    }

    private func purchase() async {
        guard case let .product(storeProduct) = viewModel.state, !isExecuted else { return }

        isExecuted = true

        // TODO: Here
        Task { @MainActor in
            defer { isExecuted = false }

            do {
                let options = purchaseOptions?(storeProduct)
                let transaction = try await viewModel.presenter.purchase(options: options)

                purchaseCompletion?(storeProduct, .success(transaction))
            } catch {
                if error.iap != .paymentCancelled {
                    self.error = error.iap
                    purchaseCompletion?(storeProduct, .failure(error))
                }
            }
        }
    }
}
