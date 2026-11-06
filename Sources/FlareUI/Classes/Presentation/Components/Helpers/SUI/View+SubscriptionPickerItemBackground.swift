//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the label style of subscription store buttons within a view.
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(iOS 13.0, macOS 10.15, *)
public extension View {
    /// Sets the label style for subscription store buttons for the view.
    ///
    /// - Parameter style: The label style to apply to subscription store buttons.
    ///
    /// - Returns: A modified view with the specified label style for subscription store buttons.
    func subscriptionButtonLabel(_ style: SubscriptionStoreButtonLabel) -> some View {
        environment(\.subscriptionStoreButtonLabel, style)
    }
}
