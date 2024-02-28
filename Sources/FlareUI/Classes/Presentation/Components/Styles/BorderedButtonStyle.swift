//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - BorderedButtonStyle

struct BorderedButtonStyle: ButtonStyle {
    // MARK: Properties

    private var backgroundColor: Color {
        Palette.gray
    }

    // MARK: ButtonStyle

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, .horizontalPadding)
            .padding(.vertical, .verticalPadding)
            .background(backgroundColor)
            .foregroundColor(.blue)
            .mask(Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}

// MARK: Extensions

extension ButtonStyle where Self == BorderedButtonStyle {
    static var bordered: Self {
        .init()
    }
}

// MARK: Constants

private extension CGFloat {
    static let horizontalPadding = 16.0
    static let verticalPadding = 8.0
}
