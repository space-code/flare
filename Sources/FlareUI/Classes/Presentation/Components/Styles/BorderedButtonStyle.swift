//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - BorderedButtonStyle

struct BorderedButtonStyle: ButtonStyle {
    // MARK: ButtonStyle

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, .horizontalPadding)
            .padding(.vertical, .verticalPadding)
            .background(Palette.gray)
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
