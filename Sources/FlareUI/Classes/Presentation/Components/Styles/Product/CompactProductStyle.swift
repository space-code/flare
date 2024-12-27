//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

// swiftlint:disable file_types_order

import SwiftUI

#if swift(>=6.0)
    public struct CompactProductStyle: @preconcurrency IProductStyle {
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
        @MainActor
        public func makeBody(configuration: ProductStyleConfiguration) -> some View {
            switch configuration.state {
            case .loading:
                ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .compact)
            case let .product(product):
                let viewModel = viewModelFactory.make(product, style: .compact)
                ProductInfoView(viewModel: viewModel, icon: configuration.icon, style: .compact) { configuration.purchase() }
            case .error:
                ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .compact)
            }
        }
    }
#else
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
        @MainActor
        public func makeBody(configuration: ProductStyleConfiguration) -> some View {
            switch configuration.state {
            case .loading:
                ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .compact)
            case let .product(product):
                let viewModel = viewModelFactory.make(product, style: .compact)
                ProductInfoView(viewModel: viewModel, icon: configuration.icon, style: .compact) { configuration.purchase() }
            case .error:
                ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .compact)
            }
        }
    }
#endif

// swiftlint:enable file_types_order
