//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProminentPickerSubscriptionStoreControlStyle

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
// swiftlint:disable:next type_name
public struct ProminentPickerSubscriptionStoreControlStyle: ISubscriptionControlStyle {
    // MARK: Initialization

    public init() {}

    // MARK: ISubscriptionControlStyle

    public func makeBody(configuration: Configuration) -> some View {
        PickerSubscriptionStoreControlStyle().makeBody(configuration: configuration)
            .overlay(overlayView(configuration: configuration))
    }

    // MARK: Private

    private var rectangleBackground: RoundedRectangle {
        RoundedRectangle(cornerSize: .cornerSize)
    }

    private func overlayView(configuration: Configuration) -> some View {
        rectangleBackground
            .strokeBorder(configuration.subscriptionViewTint, lineWidth: 2)
            .opacity((configuration.isSelected) ? 1.0 : .zero)
    }
}

// MARK: - Constants

private extension CGSize {
    static let cornerSize = CGSize(width: 18, height: 18)
}

// MARK: - Preview

#if swift(>=5.9) && os(iOS)
    #Preview {
        ProminentPickerSubscriptionStoreControlStyle().makeBody(
            configuration: .init(
                label: .init(Text("Name").eraseToAnyView()),
                description: .init(Text("Name").eraseToAnyView()),
                price: .init(Text("Name").eraseToAnyView()),
                isSelected: true,
                subscriptionPickerItemBackground: Palette.systemGray5,
                subscriptionViewTint: .green,
                action: {}
            )
        )
    }
#endif