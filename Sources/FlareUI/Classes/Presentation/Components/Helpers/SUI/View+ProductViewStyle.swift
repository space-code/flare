//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func productViewStyle(_ style: some IProductStyle) -> some View {
        environment(\.productViewStyle, AnyProductStyle(style: style))
    }
}
