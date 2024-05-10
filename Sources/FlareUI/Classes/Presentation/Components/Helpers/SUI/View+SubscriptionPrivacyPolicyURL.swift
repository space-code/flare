//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the URL of the privacy policy for a subscription within a view.
public extension View {
    /// Sets the URL for the privacy policy of the subscription view.
    ///
    /// - Parameter url: The URL of the privacy policy.
    ///
    /// - Returns: A modified view with the specified URL for the privacy policy.
    @available(iOS 13.0, *)
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    func subscriptionPrivacyPolicyURL(_ url: URL?) -> some View {
        environment(\.subscriptionPrivacyPolicyURL, url)
    }
}
