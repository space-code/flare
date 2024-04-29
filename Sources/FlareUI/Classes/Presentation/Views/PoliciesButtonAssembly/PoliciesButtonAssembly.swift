//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - IPoliciesButtonAssembly

@available(watchOS, unavailable)
protocol IPoliciesButtonAssembly {
    func assemble() -> PoliciesButtonView
}

// MARK: - PoliciesButtonAssembly

@available(watchOS, unavailable)
final class PoliciesButtonAssembly: IPoliciesButtonAssembly {
    func assemble() -> PoliciesButtonView {
        PoliciesButtonView()
    }
}
