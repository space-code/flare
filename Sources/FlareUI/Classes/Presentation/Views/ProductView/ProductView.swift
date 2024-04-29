//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct ProductView: View {
    // MARK: Properties

    private let presentationAssembly = PresentationAssembly()

    private let id: String

    // MARK: Initialization

    public init(id: String) {
        self.id = id
    }

    // MARK: View

    public var body: some View {
        presentationAssembly.productViewAssembly.assemble(id: id)
    }
}
