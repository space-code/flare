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
            ProductInfoView(viewModel: viewModel) { configuration.purchase() }
        case let .error(error):
            Text(error.localizedDescription)
        }
    }

    // MARK: Private

    @ViewBuilder
    private var loadingView: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2.0) {
                Color(UIColor.systemGray6)
                    .frame(width: 123, height: 20.0)
                    .mask(RoundedRectangle(cornerRadius: 4.0))
                Color(UIColor.systemGray6)
                    .frame(width: 208, height: 14.0)
                    .mask(RoundedRectangle(cornerRadius: 4.0))
            }
            Spacer()
            Color(UIColor.systemGray6)
                .frame(width: 76, height: 34.0)
                .mask(Capsule())
        }
        .frame(height: 34.0)
        .padding(.vertical, 2.0)
    }
}
