//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
@available(tvOS, unavailable)
@available(macOS, unavailable)
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
        .buttonStyle(PrimaryButtonStyle())
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
            .contrast(tintColor)
    }
}
