//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - IPoliciesButtonAssembly

protocol IPoliciesButtonAssembly {
    func assemble() -> PoliciesButtonView
}

// MARK: - PoliciesButtonAssembly

final class PoliciesButtonAssembly: IPoliciesButtonAssembly {
    func assemble() -> PoliciesButtonView {
        PoliciesButtonView()
    }
}
