//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct PaywallViewModifier: ViewModifier {
    // MARK: Properties

    private let paywallType: PaywallType
    private let presented: Binding<Bool>
    private let presentationAssembly: IPresentationAssembly

    // MARK: Initialization

    init(paywallType: PaywallType, presented: Binding<Bool>, presentationAssembly: IPresentationAssembly) {
        self.paywallType = paywallType
        self.presented = presented
        self.presentationAssembly = presentationAssembly
    }

    // MARK: ViewModifier

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: presented) {
                PaywallView(
                    paywallType: paywallType,
                    productsAssembly: presentationAssembly.productsViewAssembly,
                    subscriptionsAssembly: presentationAssembly.subscritpionsViewAssembly
                )
            }
    }
}
