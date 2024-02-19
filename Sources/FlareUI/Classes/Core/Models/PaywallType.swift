//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public enum PaywallType {
    case subscriptions(type: SubscptionType)
    case products(productIDs: Set<String>)
}
