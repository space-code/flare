//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the marketing content of a subscription within a view.
public extension View {
    /// Sets the marketing content for the subscription view.
    ///
    /// - Parameter view: A closure that returns the marketing content as a view.
    ///
    /// - Returns: A modified view with the specified marketing content for the subscription.
    func subscriptionMarketingContent(@ViewBuilder view: () -> some View) -> some View {
        environment(\.subscriptionMarketingContent, view().eraseToAnyView())
    }
}
