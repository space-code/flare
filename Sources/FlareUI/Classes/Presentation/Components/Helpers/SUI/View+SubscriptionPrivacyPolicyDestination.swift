//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func subscriptionPrivacyPolicyDestination(@ViewBuilder content: () -> some View) -> some View {
        environment(\.subscriptionPrivacyPolicyDestination, content().eraseToAnyView())
    }
}
