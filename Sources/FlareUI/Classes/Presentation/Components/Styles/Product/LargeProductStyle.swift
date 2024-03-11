//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(iOS 13, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
struct LargeProductStyle: IProductStyle {
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
            ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .large)
        case let .product(product):
            let viewModel = viewModelFactory.make(product)
            ProductInfoView(viewModel: viewModel, icon: configuration.icon, style: .large) { configuration.purchase() }
        case .error:
            ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .large)
        }
    }
}
