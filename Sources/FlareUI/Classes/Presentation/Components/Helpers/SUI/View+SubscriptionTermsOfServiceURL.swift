//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the URL of the terms of service for a subscription within a view.
public extension View {
    /// Sets the URL for the terms of service of the subscription view.
    ///
    /// - Parameter url: The URL of the terms of service.
    ///
    /// - Returns: A modified view with the specified URL for the terms of service.
    @available(iOS 13.0, *)
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    func subscriptionTermsOfServiceURL(_ url: URL?) -> some View {
        environment(\.subscriptionTermsOfServiceURL, url)
    }
}
