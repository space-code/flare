//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public struct CompactProductStyle: IProductStyle {
    // MARK: Properties

    private var viewModelFactory: IProductViewModelFactory

    // MARK: Initialization

    public init() {
        self.init(viewModelFactory: ProductViewModelFactory())
    }

    init(viewModelFactory: IProductViewModelFactory = ProductViewModelFactory()) {
        self.viewModelFactory = viewModelFactory
    }

    // MARK: IProductStyle

    @ViewBuilder
    public func makeBody(configuration: ProductStyleConfiguration) -> some View {
        switch configuration.state {
        case .loading:
            ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .compact)
        case let .product(product):
            let viewModel = viewModelFactory.make(product)
            ProductInfoView(viewModel: viewModel, icon: configuration.icon, style: .compact) { configuration.purchase() }
        case .error:
            ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .compact)
        }
    }
}
