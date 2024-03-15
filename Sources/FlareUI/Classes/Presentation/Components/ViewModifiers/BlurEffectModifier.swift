//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct BlurEffectModifier: ViewModifier {
    init() {}

    func body(content: Content) -> some View {
        content
            .overlay(BlurVisualEffectView())
    }
}
