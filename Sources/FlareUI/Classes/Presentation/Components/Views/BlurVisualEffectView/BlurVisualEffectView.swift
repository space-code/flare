//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - BlurVisualEffectView

#if os(iOS) || os(tvOS)
    struct BlurVisualEffectView: UIViewRepresentable {
        func makeUIView(context: Context) -> UIVisualEffectView {
            UIVisualEffectView(effect: UIBlurEffect(style: context.environment.blurEffectStyle))
        }

        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
            uiView.effect = UIBlurEffect(style: context.environment.blurEffectStyle)
        }
    }

    extension View {
        /// Creates a blur effect.
        func blurEffect() -> some View {
            ModifiedContent(content: self, modifier: BlurEffectModifier())
        }
    }
#endif
