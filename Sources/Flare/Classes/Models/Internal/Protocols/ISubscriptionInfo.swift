//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

protocol ISubscriptionInfo {
    var subscriptionStatus: [SubscriptionInfoStatus] { get async throws }
}
