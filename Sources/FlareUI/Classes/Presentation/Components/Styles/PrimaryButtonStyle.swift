//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(height: 50.0)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerSize: .init(width: 14, height: 14)))
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}
