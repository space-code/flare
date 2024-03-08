//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct PaywallView: View {
    // MARK: Properties

    private let paywallType: PaywallType

    // FIXME: Lazy
    private let productsAssembly: IProductsViewAssembly
    private let subscriptionsAssembly: ISubscriptionAssembly

    // MARK: Initialization

    init(
        paywallType: PaywallType,
        productsAssembly: IProductsViewAssembly,
        subscriptionsAssembly: ISubscriptionAssembly
    ) {
        self.paywallType = paywallType
        self.productsAssembly = productsAssembly
        self.subscriptionsAssembly = subscriptionsAssembly
    }

    // MARK: View

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                switch paywallType {
                case let .subscriptions(type):
                    AnyView(subscriptionsAssembly.assembly(type: type))
                case let .products(productIDs):
                    AnyView(productsAssembly.assemble(ids: productIDs))
                }
            }
        }
    }
}
