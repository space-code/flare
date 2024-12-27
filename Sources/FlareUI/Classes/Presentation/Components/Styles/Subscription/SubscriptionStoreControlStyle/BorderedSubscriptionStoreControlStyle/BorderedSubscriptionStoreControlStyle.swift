//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - BorderedSubscriptionStoreControlStyle

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
struct BorderedSubscriptionStoreControlStyle: ISubscriptionControlStyle {
    // MARK: Properties

    init() {}

    // MARK: ISubscriptionControlStyle

    @MainActor
    func makeBody(configuration: Configuration) -> some View {
        BorderedSubscriptionStoreControlStyleView(configuration: configuration)
    }
}

// MARK: - Preview

#if swift(>=5.9) && os(iOS)
    #Preview {
        VStack {
            BorderedSubscriptionStoreControlStyle().makeBody(
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
    }
#endif
