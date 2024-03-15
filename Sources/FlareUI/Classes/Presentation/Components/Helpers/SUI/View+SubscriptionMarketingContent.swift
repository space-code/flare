//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func subscriptionMarketingContent(@ViewBuilder view: () -> some View) -> some View {
        environment(\.subscriptionMarketingContent, view().eraseToAnyView())
    }
}
