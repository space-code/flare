//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(watchOS, unavailable)
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
        case let .subscriptions(productIDs):
            let productIDs: any Collection<String> = productIDs
            presentationAssembly.subscritpionsViewAssembly.assemble(ids: productIDs)
        case let .products(productIDs):
            let productIDs: any Collection<String> = productIDs
            presentationAssembly.productsViewAssembly.assemble(ids: productIDs)
        }
    }
}
