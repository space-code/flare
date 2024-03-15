//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// An enum represents a subscription type.
public enum SubscptionType {
    /// Represents a subscription type identified by a group ID.
    case groupID(id: String)

    /// Represents a subscription type for multiple subscriptions identified by their IDs.
    case subscriptions(ids: Set<String>)
}
