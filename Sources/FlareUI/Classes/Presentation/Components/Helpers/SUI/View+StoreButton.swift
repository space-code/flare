//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the visibility and types of store buttons within a view.
public extension View {
    /// Sets the visibility and types of store buttons for the view.
    ///
    /// - Parameters:
    ///   - visibility: The visibility of the store buttons (visible or hidden).
    ///   - types: The types of store buttons to show or hide.
    ///
    /// - Returns: A modified view with the specified store button configuration.
    func storeButton(_ visibility: StoreButtonVisibility, types: StoreButtonType...) -> some View {
        transformEnvironment(\.storeButton) { values in
            if visibility == .hidden {
                values = values.filter { !types.contains($0) }
            } else {
                let types = types.removingDuplicates()
                let diff = types.filter { !values.contains($0) }
                values += diff
            }
        }
    }

    /// Sets the visibility and types of store buttons for the view.
    ///
    /// - Parameters:
    ///   - visibility: The visibility of the store buttons (visible or hidden).
    ///   - types: The types of store buttons to show or hide.
    ///
    /// - Returns: A modified view with the specified store button configuration.
    func storeButton(_ visibility: StoreButtonVisibility, types: [StoreButtonType]) -> some View {
        transformEnvironment(\.storeButton) { values in
            if visibility == .hidden {
                values = values.filter { !types.contains($0) }
            } else {
                let types = types.removingDuplicates()
                let diff = types.filter { !values.contains($0) }
                values += diff
            }
        }
    }
}
