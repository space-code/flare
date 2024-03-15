//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func subscriptionControlStyle(_ style: SubscriptionControlStyle) -> some View {
        environment(\.subscriptionControlStyle, style)
    }
}
