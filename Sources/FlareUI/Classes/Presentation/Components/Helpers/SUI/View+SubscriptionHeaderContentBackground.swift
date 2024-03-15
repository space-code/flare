//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func subscriptionHeaderContentBackground(_ color: Color) -> some View {
        environment(\.subscriptionHeaderContentBackground, color)
    }
}
