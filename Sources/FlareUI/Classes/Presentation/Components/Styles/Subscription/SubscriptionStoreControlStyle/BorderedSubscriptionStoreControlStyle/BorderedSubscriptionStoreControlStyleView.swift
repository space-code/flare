//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - BorderedSubscriptionStoreControlStyleView

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
// swiftlint:disable:next type_name
struct BorderedSubscriptionStoreControlStyleView: View {
    // MARK: Properties

    @Environment(\.subscriptionStoreButtonLabel) private var subscriptionStoreButtonLabel
    @Environment(\.tintColor) private var tintColor

    private let configuration: ISubscriptionControlStyle.Configuration

    // MARK: Initialization

    init(configuration: ISubscriptionControlStyle.Configuration) {
        self.configuration = configuration
    }

    // MARK: View

    var body: some View {
        Button(action: {
            configuration.trigger()
        }, label: {
            labelView(configuration)
        })
        .disabled(!configuration.isActive)
        .buttonStyle(PrimaryButtonStyle(disabled: !configuration.isActive))
    }

    // MARK: Private

    @ViewBuilder
    private func labelView(_ configuration: ISubscriptionControlStyle.Configuration) -> some View {
        switch subscriptionStoreButtonLabel {
        case .action:
            textView
        case .displayName:
            configuration.label
                .font(.body.weight(.bold))
                .contrast(tintColor)
        case .multiline:
            VStack {
                configuration.label
                    .font(.body.weight(.bold))
                    .contrast(tintColor)

                if configuration.isActive {
                    Text(L10n.Common.Subscription.Status.yourCurrentPlan)
                        .font(.footnote.weight(.medium))
                        .contrast(tintColor)
                } else {
                    configuration.price
                        .font(.footnote.weight(.medium))
                        .contrast(tintColor)
                }
            }
        case .price:
            configuration.price
                .font(.footnote.weight(.medium))
        }
    }

    private var textView: some View {
        VStack {
            Text(L10n.Common.Subscription.Action.subscribe)
                .font(.body)
                .fontWeight(.bold)
                .contrast(tintColor)
        }
    }
}

#if swift(>=5.9) && os(iOS)
    #Preview {
        BorderedSubscriptionStoreControlStyleView(
            configuration: .init(
                label: .init(Text("Name")),
                description: .init(Text("Name")),
                price: .init(Text("Name")),
                isSelected: true,
                isActive: false,
                action: {}
            )
        )
    }
#endif
