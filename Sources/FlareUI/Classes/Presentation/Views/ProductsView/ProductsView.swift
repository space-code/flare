//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public struct ProductsView: View {
    // MARK: Properties

    private let presentationAssembly = PresentationAssembly()

    private let ids: Set<String>

    // MARK: Initialization

    public init(ids: Set<String>) {
        self.ids = ids
    }

    // MARK: View

    public var body: some View {
        presentationAssembly.productsViewAssembly.assemble(ids: ids)
    }
}
