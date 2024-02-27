//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A view modifier provides a paywall functionality.
struct PaywallViewModifier: ViewModifier {
    // MARK: Properties

    /// The paywall type.
    private let paywallType: PaywallType
    /// The binding to control the presentation state of the paywall.
    private let presented: Binding<Bool>
    /// The presentation assembly.
    private let presentationAssembly: IPresentationAssembly

    // MARK: Initialization

    /// Creates a `PaywallViewModifier` instance.
    ///
    /// - Parameters:
    ///   - paywallType: The paywall type.
    ///   - presented: The binding to control the presentation state of the paywall.
    ///   - presentationAssembly: The presentation assembly.
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
