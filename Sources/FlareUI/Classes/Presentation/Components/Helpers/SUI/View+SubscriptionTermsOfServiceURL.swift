//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the URL of the terms of service for a subscription within a view.
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(macOS, unavailable)
@available(iOS 13.0, *)
public extension View {
    /// Sets the URL for the terms of service of the subscription view.
    ///
    /// - Parameter url: The URL of the terms of service.
    ///
    /// - Returns: A modified view with the specified URL for the terms of service.
    func subscriptionTermsOfServiceURL(_ url: URL?) -> some View {
        environment(\.subscriptionTermsOfServiceURL, url)
    }
}
