//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for applying a specific style to a view representing a product.
public extension View {
    /// Sets the style for the product view.
    ///
    /// - Parameter style: The style to apply to the product view.
    ///
    /// - Returns: A modified view with the specified style applied.
    func productViewStyle(_ style: some IProductStyle) -> some View {
        environment(\.productViewStyle, AnyProductStyle(style: style))
    }
}
