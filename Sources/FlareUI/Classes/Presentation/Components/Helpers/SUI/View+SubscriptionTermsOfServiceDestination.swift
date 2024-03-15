//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func subscriptionTermsOfServiceDestination(@ViewBuilder content: () -> some View) -> some View {
        environment(\.subscriptionTermsOfServiceDestination, content().eraseToAnyView())
    }
}
