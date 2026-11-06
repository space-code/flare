//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the URL of the privacy policy for a subscription within a view.
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(macOS, unavailable)
@available(iOS 13.0, *)
public extension View {
    /// Sets the URL for the privacy policy of the subscription view.
    ///
    /// - Parameter url: The URL of the privacy policy.
    ///
    /// - Returns: A modified view with the specified URL for the privacy policy.
    func subscriptionPrivacyPolicyURL(_ url: URL?) -> some View {
        environment(\.subscriptionPrivacyPolicyURL, url)
    }
}
