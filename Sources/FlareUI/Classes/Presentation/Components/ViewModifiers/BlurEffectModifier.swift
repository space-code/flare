//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

#if os(iOS) || os(tvOS)
    struct BlurEffectModifier: ViewModifier {
        init() {}

        func body(content: Content) -> some View {
            content
                .overlay(BlurVisualEffectView())
        }
    }
#endif
