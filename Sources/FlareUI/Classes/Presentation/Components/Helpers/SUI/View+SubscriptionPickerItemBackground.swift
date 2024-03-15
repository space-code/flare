//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func subscriptionButtonLabel(_ style: SubscriptionStoreButtonLabel) -> some View {
        environment(\.subscriptionStoreButtonLabel, style)
    }
}
