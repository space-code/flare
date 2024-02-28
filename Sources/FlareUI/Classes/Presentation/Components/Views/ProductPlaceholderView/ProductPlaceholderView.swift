//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductPlaceholderView

struct ProductPlaceholderView: View {
    // MARK: View

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: .spacing) {
                Palette.gray
                    .frame(width: .titleWidth, height: .titleHeight)
                    .mask(RoundedRectangle(cornerRadius: .cornerRadius4px))
                Palette.gray
                    .frame(width: .descriptionWidth, height: .descriptionHeight)
                    .mask(RoundedRectangle(cornerRadius: .cornerRadius4px))
            }
            Spacer()
            Palette.gray
                .frame(width: .buttonWidth, height: .buttonHeight)
                .mask(Capsule())
        }
        .frame(height: .height)
        .padding(.vertical, .spacing)
    }
}

// MARK: Preview

#if swift(>=5.9)
    #Preview {
        ProductPlaceholderView()
    }
#endif

// MARK: Constants

private extension CGFloat {
    static let spacing = 2.0
    static let height = 34.0
    static let titleWidth = 123.0
    static let titleHeight = 20.0
    static let descriptionWidth = 208.0
    static let descriptionHeight = 14.0
    static let buttonWidth = 76.0
    static let buttonHeight = 34.0
}
