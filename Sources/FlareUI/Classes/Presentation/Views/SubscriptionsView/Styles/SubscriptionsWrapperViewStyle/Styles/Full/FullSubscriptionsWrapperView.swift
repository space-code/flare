//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
struct FullSubscriptionsWrapperView: View {
    // MARK: Properties

    @Environment(\.subscriptionMarketingContent) private var subscriptionMarketingContent
    @Environment(\.subscriptionBackground) private var subscriptionBackground

    private let configuration: SubscriptionsWrapperViewStyleConfiguration

    // MARK: Initialization

    init(configuration: SubscriptionsWrapperViewStyleConfiguration) {
        self.configuration = configuration
    }

    // MARK: View

    var body: some View {
        VStack(spacing: .zero) {
            productsView(products: configuration.items)
        }
        .background(subscriptionBackground.edgesIgnoringSafeArea(.all))
    }

    // MARK: Private

    private func productsView(products: [SubscriptionView.ViewModel]) -> some View {
        VStack(alignment: .center, spacing: .zero) {
            GeometryReader { geo in
                ScrollView(.vertical) {
                    SubscriptionHeaderView(topInset: geo.safeAreaInsets.top)

                    VStack {
                        ForEach(products) { viewModel in
                            SubscriptionView(
                                viewModel: viewModel,
                                isSelected: .constant(viewModel.id == configuration.selectedID)
                            ) {
                                self.configuration.action(viewModel)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                }
                .edgesIgnoringSafeArea(subscriptionMarketingContent != nil ? .top : [])
            }
        }
    }
}
