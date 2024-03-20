//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - BorderedSubscriptionStoreControlStyle

@available(iOS 13.0, *)
@available(tvOS, unavailable)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
struct BorderedSubscriptionStoreControlStyle: ISubscriptionControlStyle {
//    // MARK: Properties
//
//    private let subscriptionStoreButtonLabel: SubscriptionStoreButtonLabel
//
//    // MARK: Properties
//
//    init(environment: EnvironmentValues) {
//        subscriptionStoreButtonLabel = environment.subscriptionStoreButtonLabel
//    }

    // MARK: ISubscriptionControlStyle

    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.trigger()
        }, label: {
            labelView(configuration)
        })
        .buttonStyle(PrimaryButtonStyle())
    }

    // MARK: Private

    @ViewBuilder
    private func labelView(_ configuration: Configuration) -> some View {
        switch subscriptionStoreButtonLabel {
        case .action:
            textView
        case .displayName:
            configuration.label
                .font(.body.weight(.bold))
        case .multiline:
            VStack {
                textView
                configuration.price
                    .font(.footnote.weight(.medium))
            }
        case .price:
            configuration.price
                .font(.footnote.weight(.medium))
        }
    }

    private var textView: some View {
        Text("Subscribe")
            .font(.body)
            .fontWeight(.bold)
//            .contrast(tintColor)
    }
}

// MARK: - Preview

#if swift(>=5.9) && os(iOS)
    #Preview {
        VStack {
            BorderedSubscriptionStoreControlStyle(
                environment: EnvironmentValues()
            ).makeBody(
                configuration: .init(
                    label: .init(Text("Name")),
                    description: .init(Text("Name")),
                    price: .init(Text("Name")),
                    isSelected: true,
                    subscriptionPickerItemBackground: Palette.systemGray5,
                    subscriptionViewTint: .green,
                    action: {}
                )
            )
            BorderedSubscriptionStoreControlStyle(
                environment: EnvironmentValues()
            ).makeBody(
                configuration: .init(
                    label: .init(Text("Name")),
                    description: .init(Text("Name")),
                    price: .init(Text("Name")),
                    isSelected: true,
                    subscriptionPickerItemBackground: Palette.systemGray5,
                    subscriptionViewTint: .green,
                    action: {}
                )
            )
        }
    }
#endif
