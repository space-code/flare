//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func subscriptionControlStyle(_ style: some ISubscriptionControlStyle) -> some View {
        if let style = style as? AnySubscriptionControlStyle {
            environment(\.subscriptionControlStyle, style)
        } else {
            environment(\.subscriptionControlStyle, AnySubscriptionControlStyle(style: style))
        }
    }
}
