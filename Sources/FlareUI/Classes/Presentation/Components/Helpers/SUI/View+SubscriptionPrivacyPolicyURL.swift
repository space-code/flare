//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    @available(iOS 13.0, *)
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    func subscriptionPrivacyPolicyURL(_ url: URL?) -> some View {
        environment(\.subscriptionPrivacyPolicyURL, url)
    }
}
