//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProminentPickerSubscriptionStoreControlStyleView

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
// swiftlint:disable:next type_name
struct ProminentPickerSubscriptionStoreControlStyleView: View {
    // MARK: Properties

    @Environment(\.subscriptionViewTint) private var tintColor

    private let configuration: ISubscriptionControlStyle.Configuration

    // MARK: Initialization

    init(configuration: ISubscriptionControlStyle.Configuration) {
        self.configuration = configuration
    }

    // MARK: View

    var body: some View {
        PickerSubscriptionStoreControlStyle().makeBody(configuration: configuration)
            .overlay(overlayView(configuration: configuration))
    }

    // MARK: Private

    private var rectangleBackground: RoundedRectangle {
        RoundedRectangle(cornerSize: .cornerSize)
    }

    private func overlayView(configuration: ISubscriptionControlStyle.Configuration) -> some View {
        rectangleBackground
            .strokeBorder(tintColor, lineWidth: 2)
            .opacity((configuration.isSelected) ? 1.0 : .zero)
    }
}

// MARK: - Constants

private extension CGSize {
    static let cornerSize = CGSize(width: 18, height: 18)
}
