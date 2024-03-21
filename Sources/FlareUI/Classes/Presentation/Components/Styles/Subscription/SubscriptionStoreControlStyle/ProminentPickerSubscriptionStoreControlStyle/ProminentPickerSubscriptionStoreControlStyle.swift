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
        ProminentPickerSubscriptionStoreControlStyleView(configuration: configuration)
    }
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
                action: {}
            )
        )
    }
#endif
