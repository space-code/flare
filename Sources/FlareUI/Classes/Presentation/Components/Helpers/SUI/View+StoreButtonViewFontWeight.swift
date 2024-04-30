//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the font weight of store button views within a view.
extension View {
    /// Sets the font weight of store button views for the view.
    ///
    /// - Parameter weight: The font weight to apply to store button views.
    ///
    /// - Returns: A modified view with the specified font weight for store button views.
    func storeButtonViewFontWeight(_ weight: Font.Weight) -> some View {
        environment(\.storeButtonViewFontWeight, weight)
    }
}
