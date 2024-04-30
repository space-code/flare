//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the tint color of views within a view hierarchy.
public extension View {
    /// Sets the tint color for views in the view hierarchy.
    ///
    /// - Parameter color: The tint color to apply to views.
    ///
    /// - Returns: A modified view with the specified tint color for views.
    func tintColor(_ color: Color) -> some View {
        environment(\.tintColor, color)
    }
}
