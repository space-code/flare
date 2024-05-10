//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - StoreButtonType

/// Enum representing different types of buttons in a store.
public enum StoreButtonType {
    /// Button for restoring purchases.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    case restore

    /// Button for displaying store policies.
    case policies
}
