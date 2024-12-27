//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - TintColorKey

private struct TintColorKey: EnvironmentKey {
    static var defaultValue: Color { .blue }
}

extension EnvironmentValues {
    var tintColor: Color {
        get { self[TintColorKey.self] }
        set { self[TintColorKey.self] = newValue }
    }
}
