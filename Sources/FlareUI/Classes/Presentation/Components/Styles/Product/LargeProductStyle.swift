//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// swiftlint:disable file_types_order

#if swift(>=6.0)
    @available(iOS 13, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public struct LargeProductStyle: @preconcurrency IProductStyle {
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
                ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .large)
            case let .product(product):
                let viewModel = viewModelFactory.make(product, style: .large)
                ProductInfoView(viewModel: viewModel, icon: configuration.icon, style: .large) { configuration.purchase() }
            case .error:
                ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .large)
            }
        }
    }
#else
    @available(iOS 13, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public struct LargeProductStyle: IProductStyle {
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
                ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .large)
            case let .product(product):
                let viewModel = viewModelFactory.make(product, style: .large)
                ProductInfoView(viewModel: viewModel, icon: configuration.icon, style: .large) { configuration.purchase() }
            case .error:
                ProductPlaceholderView(isIconHidden: configuration.icon == nil, style: .large)
            }
        }
    }
#endif

// swiftlint:enable file_types_order
