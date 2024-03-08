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
            ProductPlaceholderView(isIconHidden: configuration.icon == nil)
        case let .product(product):
            let viewModel = viewModelFactory.make(product)
            ProductInfoView(viewModel: viewModel, icon: configuration.icon) { configuration.purchase() }
        case .error:
            ProductPlaceholderView(isIconHidden: configuration.icon == nil)
        }
    }
}
