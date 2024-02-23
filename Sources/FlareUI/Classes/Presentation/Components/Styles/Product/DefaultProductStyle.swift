//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct DefaultProductStyle: IProductStyle {
    // MARK: Properties

    private var viewModelFactory: IProductViewModelFactory

    // MARK: Initialization

    init(viewModelFactory: IProductViewModelFactory = ProductViewModelFactory()) {
        self.viewModelFactory = viewModelFactory
    }

    // MARK: IProductStyle

    @ViewBuilder
    func makeBody(configuration: ProductStyleConfiguration) -> some View {
        switch configuration.state {
        case .loading:
            loadingView
        case let .product(product):
            let viewModel = viewModelFactory.make(product)
            ProductInfoView(viewModel: viewModel) {
                configuration.purchase()
            }
        }
    }

    // MARK: Private

    private var loadingView: some View {
        HStack(alignment: .center) {
            if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                ProgressView()
            } else {
                Text("Loading")
            }
        }
    }
}
