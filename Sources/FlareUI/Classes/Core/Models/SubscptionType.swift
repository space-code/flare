//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public enum SubscptionType {
    case groupID(id: String)
    case subscriptions(ids: Set<String>)
}
