//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A view for displaying subscriptions.
@available(iOS 13.0, tvOS 13.0, macOS 11.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct SubscriptionsView: View {
    // MARK: Properties

    /// The presentation assembly for creating views.
    private let presentationAssembly = PresentationAssembly()

    /// The IDs of the subscriptions to display.
    private let ids: any Collection<String>

    // MARK: Initialization

    /// Initializes the subscriptions view with the given IDs.
    ///
    /// - Parameter ids: The IDs of the subscriptions to display.
    public init(ids: some Collection<String>) {
        self.ids = ids
    }

    // MARK: View

    public var body: some View {
        presentationAssembly.subscritpionsViewAssembly.assemble(ids: ids)
    }
}
