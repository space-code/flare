//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the destination of the privacy policy for a subscription within a view.
public extension View {
    /// Sets the destination for the privacy policy of the subscription view.
    ///
    /// - Parameter content: A closure that returns the view representing the destination.
    ///
    /// - Returns: A modified view with the specified destination for the privacy policy.
    func subscriptionPrivacyPolicyDestination(@ViewBuilder content: () -> some View) -> some View {
        environment(\.subscriptionPrivacyPolicyDestination, content().eraseToAnyView())
    }
}
