//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// swiftlint:disable identifier_name
extension View {
    func contrast(
        _ backgroundColor: Color,
        lightColor: Color = .white,
        darkColor: Color = .black
    ) -> some View {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        backgroundColor.uiColor().getRed(&r, green: &g, blue: &b, alpha: &a)
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return luminance < 0.6 ? foregroundColor(lightColor) : foregroundColor(darkColor)
    }
}

// swiftlint:enable identifier_name
