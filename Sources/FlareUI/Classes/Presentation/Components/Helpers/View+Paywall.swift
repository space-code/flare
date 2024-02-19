//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func paywall(presented: Binding<Bool>, paywallType: PaywallType) -> some View {
        modifier(
            PaywallViewModifier(
                paywallType: paywallType,
                presented: presented,
                presentationAssembly: PresentationAssembly(dependencies: FlareDependencies())
            )
        )
    }
}
