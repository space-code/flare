//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - PrimaryButtonStyle

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
struct PrimaryButtonStyle: ButtonStyle {
    // MARK: Properties

    private let disabled: Bool

    @Environment(\.tintColor) private var tintColor

    // MARK: Initialization

    init(disabled: Bool) {
        self.disabled = disabled
    }

    // MARK: ButtonStyle

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(height: 50.0)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background(disabled ? Palette.systemGray : tintColor)
            .clipShape(RoundedRectangle(cornerSize: .init(width: 14, height: 14)))
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}

// MARK: - Extensions

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle(disabled: true)
    }
}
