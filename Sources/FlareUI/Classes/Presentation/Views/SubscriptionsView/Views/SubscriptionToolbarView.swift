//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionToolbarView

@available(iOS 13.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
struct SubscriptionToolbarView: View {
    // MARK: Properties

    @Environment(\.storeButtonsAssembly) private var storeButtonsAssembly
    @Environment(\.storeButton) private var storeButton
    @Environment(\.subscriptionViewTint) private var subscriptionViewTint
    @Environment(\.subscriptionBackground) private var subscriptionBackground

    private let viewModel: ViewModel
    private let action: () -> Void

    // MARK: Initialization

    init(viewModel: ViewModel, action: @escaping () -> Void) {
        self.viewModel = viewModel
        self.action = action
    }

    // MARK: View

    var body: some View {
        bottomToolbar { purchaseContainer }
            .background(
                Color.clear
                    .blurEffect()
                    .edgesIgnoringSafeArea(.all)
            )
    }

    // MARK: Private

    private var purchaseContainer: some View {
        VStack(spacing: 24.0) {
            subscriptionsDetailsView {
                SubscriptionView(
                    viewModel: .init(
                        id: viewModel.id,
                        title: viewModel.title,
                        price: viewModel.price,
                        description: viewModel.description
                    ),
                    isSelected: .constant(false),
                    action: action
                )
                .subscriptionControlStyle(.button)
                .subscriptionButtonLabel(.multiline)
                .padding(.horizontal)
            }

            storeButtonView
        }
    }

    private func bottomToolbar(@ViewBuilder content: () -> some View) -> some View {
        content()
            .padding(.top)
    }

    private var storeButtonView: some View {
        Group {
            if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
                if storeButton.contains(.restore) {
                    storeButtonsAssembly?.assemble(storeButtonType: .restore)
                        .storeButtonViewFontWeight(.bold)
                        .foregroundColor(subscriptionViewTint)
                }
            }
        }
    }

    private var subscriptionsDetailsView: some View {
        Text(L10n.Subscriptions.Renewable.subscriptionDescription(viewModel.price))
    }

    private func subscriptionsDetailsView(@ViewBuilder content: () -> some View) -> some View {
        VStack(spacing: 6.0) {
            content()
            subscriptionsDetailsView
                .contrast(subscriptionBackground)
                .font(.subheadline)
        }
    }
}

// MARK: SubscriptionToolbarView.ViewModel

@available(iOS 13.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension SubscriptionToolbarView {
    struct ViewModel {
        let id: String
        let title: String
        let price: String
        let description: String
    }
}

#if swift(>=5.9) && os(iOS)
    #Preview {
        VStack {
            SubscriptionToolbarView(
                viewModel: .init(
                    id: "",
                    title: "Subscription",
                    price: "$0.99/month",
                    description: "Description"
                ),
                action: {}
            )
        }
    }
#endif
