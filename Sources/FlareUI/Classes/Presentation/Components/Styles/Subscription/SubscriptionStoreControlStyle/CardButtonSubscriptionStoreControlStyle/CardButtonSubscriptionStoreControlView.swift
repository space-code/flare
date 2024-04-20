//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - CardButtonSubscriptionStoreControlView

@available(tvOS 13.0, *)
@available(iOS, unavailable)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
struct CardButtonSubscriptionStoreControlView: View {
    // MARK: Properties

//    @Environment(\.isFocused) private var isFocused: Bool
    @Environment(\.tintColor) private var tintColor

    private let configuration: SubscriptionStoreControlStyleConfiguration

    // MARK: Initialization

    init(configuration: SubscriptionStoreControlStyleConfiguration) {
        self.configuration = configuration
    }

    // MARK: View

    var body: some View {
        ZStack {
            Rectangle()
                .fill(tintColor) // isFocused ? tintColor.opacity(0.85) : tintColor)

            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    if configuration.isActive {
                        planView
                    }

                    configuration.label
                        .contrast(tintColor)
                        .font(.headline)
                    configuration.price
                        .contrast(tintColor)
                        .font(.caption.weight(.medium))
                        .layoutPriority(1)
                }

                Spacer(minLength: .zero)
                    .frame(maxWidth: .infinity)

                configuration.description
                    .contrast(tintColor)
                    .font(.footnote)
            }
            .padding()
        }
        .frame(minWidth: .minWidth, minHeight: .minHeight)
        .fixedSize(horizontal: true, vertical: true)
    }

    // MARK: Private

    private var planView: some View {
        HStack {
            Text(L10n.Common.Subscription.Status.yourPlan)
                .opacity(0.8)
                .contrast(tintColor)
                .font(.caption)
        }
    }
}

// MARK: - Constants

private extension CGFloat {
    static let minWidth = 528.0
    static let minHeight = 204.0
}

// MARK: - Preview

#if swift(>=5.9) && os(tvOS)
    #Preview {
        CardButtonSubscriptionStoreControlView(
            configuration: .init(
                label: .init(Text("Name")),
                description: .init(Text("Name")),
                price: .init(Text("Name")),
                isSelected: true,
                isActive: true,
                action: {}
            )
        )
    }
#endif
