//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// An enum represents a paywall type.
public enum PaywallType {
    /// Represents a paywall for subscriptions.
    case subscriptions(type: any Collection<String>)

    /// Represents a paywall for specific products identified by their IDs.
    case products(productIDs: any Collection<String>)
}
