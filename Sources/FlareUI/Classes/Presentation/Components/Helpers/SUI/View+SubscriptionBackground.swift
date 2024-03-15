//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func subscriptionBackground(_ color: Color) -> some View {
        environment(\.subscriptionBackground, color)
    }
}
