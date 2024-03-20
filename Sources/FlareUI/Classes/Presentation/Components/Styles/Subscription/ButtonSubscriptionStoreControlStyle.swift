//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ButtonSubscriptionStoreControlStyle

// struct BorderedSubscriptionStoreControlStyleViewModifier: ViewModifier {
//    @Environment(\.self) private var environment
//
//    private let configuration: ISubscriptionControlStyle.Configuration
//
//    init(configuration: ISubscriptionControlStyle.Configuration) {
//        self.configuration = configuration
//    }
//
//    func body(content _: Content) -> some View {
//        BorderedSubscriptionStoreControlStyle(environment: environment)
//            .makeBody(configuration: configuration)
//    }
// }
//

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
public struct ButtonSubscriptionStoreControlStyle: ISubscriptionControlStyle {
    // MARK: Initialization

    public init() {}

    // MARK: ISubscriptionControlStyle

    public func makeBody(configuration: Configuration) -> some View {
        #if os(tvOS)
            return CardButtonSubscriptionStoreControlStyle().makeBody(configuration: configuration)
        #else
            return BorderedSubscriptionStoreControlStyle().makeBody(configuration: configuration)
        #endif
    }
}

// MARK: - Preview

#if swift(>=5.9)
    #Preview {
        ButtonSubscriptionStoreControlStyle().makeBody(
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
