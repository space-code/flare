//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

#if os(tvOS)
    @available(tvOS 13.0, *)
    @available(iOS, unavailable)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    struct CardButtonSubscriptionStoreControlStyle: ISubscriptionControlStyle {
        // MARK: ISubscriptionControlStyle

        func makeBody(configuration: Configuration) -> some View {
            if #available(tvOS 15.0, *) {
                contentView(configuration: configuration)
                    .buttonStyle(CardButtonStyle())
            } else {
                contentView(configuration: configuration)
            }
        }

        // MARK: Private

        private func contentView(configuration: Configuration) -> some View {
            Button(
                action: {
                    configuration.trigger()
                }, label: {
                    CardButtonSubscriptionStoreControlView(configuration: configuration)
                }
            )
        }
    }
#endif

// MARK: - Preview

#if swift(>=5.9) && os(tvOS)
    #Preview {
        CardButtonSubscriptionStoreControlStyle().makeBody(
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
