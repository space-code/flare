//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionHeaderView

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
struct SubscriptionHeaderView: View {
    // MARK: Properties

    @Environment(\.storeButtonsAssembly) private var storeButtonsAssembly
    @Environment(\.storeButton) private var storeButton
    @Environment(\.subscriptionMarketingContent) private var subscriptionMarketingContent
    @Environment(\.subscriptionHeaderContentBackground) private var subscriptionHeaderContentBackground
    @Environment(\.subscriptionViewTint) private var subscriptionViewTint

    private let topInset: CGFloat

    // MARK: Initialization

    init(topInset: CGFloat = .zero) {
        self.topInset = topInset
    }

    // MARK: View

    var body: some View {
        VStack {
            subscriptionMarketingContent.map { content in
                content.frame(maxWidth: .infinity, minHeight: 250.0)
                    .padding(.top, topInset)
            }

            policiesButton
                .tintColor(subscriptionViewTint)
                .padding(.bottom)
        }
        .background(headerBackground)
    }

    // MARK: Private

    @ViewBuilder
    private var headerBackground: some View {
        if subscriptionMarketingContent != nil {
            subscriptionHeaderContentBackground.edgesIgnoringSafeArea(.all)
        }
    }

    @MainActor
    private var policiesButton: some View {
        Group {
            if storeButton.contains(.policies) {
                storeButtonsAssembly?.assemble(storeButtonType: .policies)
            }
        }
    }
}

#if swift(>=5.9) && os(iOS)
    #Preview {
        SubscriptionHeaderView()
    }
#endif
