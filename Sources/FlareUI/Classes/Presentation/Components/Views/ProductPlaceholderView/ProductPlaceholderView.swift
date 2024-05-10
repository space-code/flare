//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductPlaceholderView

struct ProductPlaceholderView: View {
    // MARK: Types

    enum Style {
        @available(iOS 13.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        case large
        case compact
    }

    // MARK: Properties

    private let isIconHidden: Bool
    private let style: Style

    // MARK: Initialization

    init(isIconHidden: Bool, style: Style) {
        self.isIconHidden = isIconHidden
        self.style = style
    }

    // MARK: View

    var body: some View {
        contentView
    }

    // MARK: Private

    private var contentView: some View {
        stackView(spacing: .iconSpacing) {
            if !isIconHidden {
                iconView
            }
            stackView(spacing: 8.0) {
                textView
                Spacer()
                buttonView
            }
            .padding(.padding)
        }
        .background(value(default: Color.clear, tvOS: Palette.dynamicBackground))
        .frame(height: style == .compact ? metrics(compact: .height, large: nil) : nil)
        .frame(maxHeight: metrics(compact: .height, large: .largeHeight))
        .fixedSize(horizontal: false, vertical: true)
        .padding(.vertical, value(default: .spacing, tvOS: .zero))
    }

    private var textView: some View {
        VStack(
            alignment: metrics(compact: .leading, large: .center),
            spacing: .spacing
        ) {
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
            .frame(
                idealWidth: metrics(compact: .iconWidth, large: .iconLargeWidth),
                maxWidth: metrics(compact: .iconWidth, large: .iconLargeWidth),
                idealHeight: metrics(compact: .iconHeight, large: .iconLargeHeight),
                maxHeight: metrics(compact: .iconHeight, large: .iconLargeHeight)
            )
    }

    private func metrics<T>(compact: T, large: T?) -> T {
        #if os(iOS)
            switch style {
            case .compact:
                return compact
            case .large:
                return large ?? compact
            }
        #else
            return compact
        #endif
    }

    private var buttonMask: some View {
        #if os(tvOS)
            RoundedRectangle(cornerRadius: .zero)
        #else
            Capsule()
        #endif
    }

    @ViewBuilder
    private func stackView(spacing: CGFloat = .zero, @ViewBuilder content: () -> some View) -> some View {
        #if os(iOS)
            Group {
                switch style {
                case .large:
                    VStack(spacing: spacing) {
                        content()
                    }
                case .compact:
                    HStack(spacing: spacing) {
                        content()
                    }
                }
            }
        #else
            HStack(spacing: spacing) {
                content()
            }
        #endif
    }
}

// MARK: Preview

#if swift(>=5.9)
    #Preview {
        Group {
            ForEach(0 ..< 10) { _ in
                ProductPlaceholderView(isIconHidden: true, style: .compact)
                ProductPlaceholderView(isIconHidden: false, style: .compact)
            }
        }
    }
#endif

// MARK: Constants

private extension CGFloat {
    static let padding = value(default: .zero, tvOS: 24.0)
    static let spacing = value(default: 2.0, tvOS: 10.0)
    static let height = value(default: 60.0, tvOS: 200.0)
    static let largeHeight = value(default: 200.0)
    static let titleWidth = value(default: 123.0, tvOS: 240.0)
    static let titleHeight = value(default: 20.0, tvOS: 30.0)
    static let descriptionWidth = value(default: 208.0, tvOS: 180.0)
    static let descriptionHeight = value(default: 14.0, tvOS: 24.0)
    static let buttonWidth = value(default: 76.0, tvOS: 90.0)
    static let buttonHeight = value(default: 34.0, tvOS: 25)
    static let cornerRadius = value(default: CGFloat.cornerRadius4px, tvOS: .zero)
    static let iconWidth = value(default: 60.0, tvOS: 330.0)
    static let iconHeight = value(default: 60.0, tvOS: 200.0)
    static let iconLargeWidth = value(default: 105.0)
    static let iconLargeHeight = value(default: 105.0)
    static let iconSpacing = value(default: 8.0, tvOS: .zero)
}
