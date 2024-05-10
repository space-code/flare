//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - PickerSubscriptionStoreControlStyle

@available(iOS 13.0, macOS 10.15, watchOS 7.0, *)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
public struct PickerSubscriptionStoreControlStyle: ISubscriptionControlStyle {
    // MARK: Initialization

    public init() {}

    // MARK: ISubscriptionControlStyle

    public func makeBody(configuration: Configuration) -> some View {
        PickerSubscriptionStoreControlStyleView(configuration: configuration)
    }
}

// MARK: - Preview

#if swift(>=5.9) && os(iOS)
    #Preview {
        PickerSubscriptionStoreControlStyle().makeBody(
            configuration: .init(
                label: .init(Text("Name").eraseToAnyView()),
                description: .init(Text("Name").eraseToAnyView()),
                price: .init(Text("Name").eraseToAnyView()),
                isSelected: true,
                isActive: true,
                action: {}
            )
        )
    }
#endif
