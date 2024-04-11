//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, macOS 11.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct SubscriptionsView: View {
    // MARK: Properties

    private let presentationAssembly = PresentationAssembly()

    private let ids: any Collection<String>

    // MARK: Initialization

    public init(ids: some Collection<String>) {
        self.ids = ids
    }

    // MARK: View

    public var body: some View {
        presentationAssembly.subscritpionsViewAssembly.assemble(ids: ids)
    }
}
