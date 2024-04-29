//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(tvOS 13.0, *)
@available(macOS, unavailable)
@available(iOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
struct CompactSubscriptionWrapperView: View {
    // MARK: Properties

    @Environment(\.subscriptionMarketingContent) private var subscriptionMarketingContent

    private let configuration: SubscriptionsWrapperViewStyleConfiguration

    // MARK: Initialization

    init(configuration: SubscriptionsWrapperViewStyleConfiguration) {
        self.configuration = configuration
    }

    // MARK: View

    var body: some View {
        VStack {
            subscriptionMarketingContent.map { content in
                content.frame(maxWidth: .infinity, minHeight: 150.0)
            }

            ScrollView(.horizontal) {
                HStack {
                    ForEach(configuration.items) { item in
                        SubscriptionView(viewModel: item, isSelected: .constant(false)) {
                            configuration.action(item)
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
            }
        }
    }
}
