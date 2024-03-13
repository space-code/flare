//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct PaywallView: View {
    // MARK: Properties

    private let presentationAssembly: IPresentationAssembly
    private let paywallType: PaywallType

    // MARK: Initialization

    init(
        paywallType: PaywallType,
        presentationAssembly: IPresentationAssembly = PresentationAssembly()
    ) {
        self.paywallType = paywallType
        self.presentationAssembly = presentationAssembly
    }

    // MARK: View

    var body: some View {
        switch paywallType {
        case let .subscriptions(type):
            presentationAssembly.subscritpionsViewAssembly.assemble(type: type)
        case let .products(productIDs):
            presentationAssembly.productsViewAssembly.assemble(ids: productIDs)
        }
    }
}
