//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct SubscriptionsWrapperView: View, IViewWrapper {
    // MARK: Propertirs

    private let viewModel: SubscriptionsViewModel

    // MARK: Initialization

    init(viewModel: SubscriptionsViewModel) {
        self.viewModel = viewModel
    }

    // MARK: View

    var body: some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case let .products(products):
            Text("Products")
        case .error:
            StoreUnavaliableView(productType: .subscription)
        }
    }

    // MARK: Private

    private var contentView: some View {
        Text("View")
    }

    private var loadingView: some View {
        VStack(alignment: .center, spacing: 52) {
            if #available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *) {
                progressView
                    .scaleEffect(1.74)
            } else if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *) {
                progressView
                    .controlSize(.large)
            } else {
                ActivityIndicatorView(isAnimating: .constant(true), style: .large)
            }
            Text("Loading Subscriptions...")
                .font(.subheadline)
                .foregroundColor(Palette.systemGray)
        }
    }

    @available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *)
    private var progressView: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
}
