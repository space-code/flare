//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - BlurEffectStyleKey

#if os(iOS) || os(tvOS)
    private struct BlurEffectStyleKey: EnvironmentKey {
        static let defaultValue: UIBlurEffect.Style = .light
    }

    extension EnvironmentValues {
        var blurEffectStyle: UIBlurEffect.Style {
            get { self[BlurEffectStyleKey.self] }
            set { self[BlurEffectStyleKey.self] = newValue }
        }
    }
#endif
