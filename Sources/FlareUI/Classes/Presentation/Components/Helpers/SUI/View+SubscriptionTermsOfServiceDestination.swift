//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the destination of the terms of service for a subscription within a view.
public extension View {
    /// Sets the destination for the terms of service of the subscription view.
    ///
    /// - Parameter content: A closure that returns the view representing the destination.
    ///
    /// - Returns: A modified view with the specified destination for the terms of service.
    func subscriptionTermsOfServiceDestination(@ViewBuilder content: () -> some View) -> some View {
        environment(\.subscriptionTermsOfServiceDestination, content().eraseToAnyView())
    }
}
