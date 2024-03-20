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
                    VStack(alignment: .leading) {
                        configuration.label
                            .font(.headline)
                        configuration.price
                            .font(.footnote)

                        Spacer()
                            .frame(maxWidth: .infinity)

                        configuration.description
                            .font(.footnote)
                    }
                    .padding()
                }
            )
            .frame(minWidth: .minWidth, minHeight: .minHeight)
            .fixedSize(horizontal: true, vertical: true)
        }
    }

    // MARK: - Constants

    private extension CGFloat {
        static let minWidth = 528.0
        static let minHeight = 172.0
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
                subscriptionPickerItemBackground: Palette.systemGray5,
                subscriptionViewTint: .green,
                action: {}
            )
        )
    }
#endif
