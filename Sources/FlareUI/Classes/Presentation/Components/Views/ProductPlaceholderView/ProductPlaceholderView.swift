//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductPlaceholderView

struct ProductPlaceholderView: View {
    // MARK: Properties

    private let isIconHidden: Bool

    // MARK: Initialization

    init(isIconHidden: Bool) {
        self.isIconHidden = isIconHidden
    }

    // MARK: View

    var body: some View {
        contentView
    }

    // MARK: Private

    private var contentView: some View {
        Group {
            HStack(spacing: .iconSpacing) {
                iconView
                HStack {
                    textView
                    Spacer()
                    buttonView
                }
                .padding(.padding)
            }
            .background(value(default: Color.clear, tvOS: Palette.dynamicBackground))
            .frame(height: .height)
            .padding(.vertical, value(default: .spacing, tvOS: .zero))
        }
    }

    private var textView: some View {
        VStack(alignment: .leading, spacing: .spacing) {
            Palette.gray
                .frame(
                    idealWidth: .titleWidth,
                    maxWidth: .titleWidth,
                    idealHeight: .titleHeight,
                    maxHeight: .titleHeight
                )
                .mask(RoundedRectangle(cornerRadius: .cornerRadius))
            Palette.gray
                .frame(
                    idealWidth: .descriptionWidth,
                    maxWidth: .descriptionWidth,
                    idealHeight: .descriptionHeight,
                    maxHeight: .descriptionHeight
                )
                .mask(RoundedRectangle(cornerRadius: .cornerRadius))
            #if os(tvOS)
                Spacer()
            #endif
        }
    }

    private var buttonView: some View {
        Palette.gray
            .frame(
                idealWidth: .buttonWidth,
                maxWidth: .buttonWidth,
                idealHeight: .buttonHeight,
                maxHeight: .buttonHeight
            )
            .mask(buttonMask)
    }

    private var iconView: some View {
        Palette.gray
            .frame(idealWidth: .iconWidth, maxWidth: .iconWidth, idealHeight: .height, maxHeight: .height)
    }

    private var buttonMask: some View {
        #if os(tvOS)
            RoundedRectangle(cornerRadius: .zero)
        #else
            Capsule()
        #endif
    }
}

// MARK: Preview

#if swift(>=5.9)
    #Preview {
        Group {
            ProductPlaceholderView(isIconHidden: true)
            ProductPlaceholderView(isIconHidden: false)
        }
    }
#endif

// MARK: Constants

private extension CGFloat {
    static let padding = value(default: .zero, tvOS: 24.0)
    static let spacing = value(default: 2.0, tvOS: 10.0)
    static let height = value(default: 60.0, tvOS: 200.0)
    static let titleWidth = value(default: 123.0, tvOS: 240.0)
    static let titleHeight = value(default: 20.0, tvOS: 30.0)
    static let descriptionWidth = value(default: 208.0, tvOS: 180.0)
    static let descriptionHeight = value(default: 14.0, tvOS: 24.0)
    static let buttonWidth = value(default: 76.0, tvOS: 90.0)
    static let buttonHeight = value(default: 34.0, tvOS: 25)
    static let cornerRadius = value(default: CGFloat.cornerRadius4px, tvOS: .zero)
    static let iconWidth = value(default: 60.0, tvOS: 330.0)
    static let iconHeight = value(default: 60.0, tvOS: 200.0)
    static let iconSpacing = value(default: 8.0, tvOS: .zero)
}
