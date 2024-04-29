//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func subscriptionControlStyle(_ style: some ISubscriptionControlStyle) -> some View {
        environment(\.subscriptionControlStyle, prepareStyle(style))
    }

    // MARK: Private

    private func prepareStyle(_ style: some ISubscriptionControlStyle) -> AnySubscriptionControlStyle {
        if let style = style as? AnySubscriptionControlStyle {
            return style
        } else {
            return AnySubscriptionControlStyle(style: style)
        }
    }
}
