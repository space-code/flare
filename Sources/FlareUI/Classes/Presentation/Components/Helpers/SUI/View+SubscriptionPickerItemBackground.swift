//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    @available(iOS 13.0, macOS 10.15, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    func subscriptionButtonLabel(_ style: SubscriptionStoreButtonLabel) -> some View {
        environment(\.subscriptionStoreButtonLabel, style)
    }
}
