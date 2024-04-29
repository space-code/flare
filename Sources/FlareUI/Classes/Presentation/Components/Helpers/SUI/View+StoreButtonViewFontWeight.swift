//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

extension View {
    func storeButtonViewFontWeight(_ weight: Font.Weight) -> some View {
        environment(\.storeButtonViewFontWeight, weight)
    }
}
