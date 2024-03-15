//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductInfoView

struct ProductInfoView: View {
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

    private let viewModel: ViewModel
    private let icon: ProductStyleConfiguration.Icon?
    private let style: Style
    private let action: () -> Void

    // MARK: Initialization

    init(
        viewModel: ViewModel,
        icon: ProductStyleConfiguration.Icon?,
        style: Style,
        action: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.icon = icon
        self.style = style
        self.action = action
    }

    // MARK: View

    var body: some View {
        #if os(tvOS)
            Button(action: {
                action()
            }, label: {
                contentView
            })
        #else
            contentView
        #endif
    }

    // MARK: Private

    private var contentView: some View {
        stackView(spacing: metrics(compact: nil, large: .largeSpacing)) {
            iconView

            textView
            Spacer(minLength: .zero)
            priceView
        }
        .padding(.padding)
        .frame(height: .height)
    }

    private var iconView: some View {
        icon.map { $0 }
            .frame(
                idealHeight: metrics(compact: nil, large: .largeImageHeight),
                maxHeight: metrics(compact: nil, large: .largeImageHeight)
            )
    }

    private var textView: some View {
        let alignment: HorizontalAlignment = {
            switch style {
            case .compact:
                return .leading
            case .large:
                return .center
            }
        }()

        return VStack(alignment: alignment) {
            Text(viewModel.title)
                .lineLimit(.lineLimit)
                .font(.body)
            Text(viewModel.description)
                .lineLimit(.lineLimit)
                .font(.caption)
                .foregroundColor(Palette.systemGray)
            #if os(tvOS)
                Spacer()
            #endif
        }
    }

    private var priceView: some View {
        #if os(tvOS)
            Text(viewModel.price)
        #else
            VStack(alignment: .center) {
                Button(
                    action: {
                        action()
                    },
                    label: {
                        Text(viewModel.price)
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                )
                .buttonStyle(BorderedButtonStyle())

                if style == .compact {
                    priceDescriptionView
                }
            }
        #endif
    }

    private var priceDescriptionView: some View {
        viewModel.priceDescription.map {
            Text($0)
                .font(.system(size: .priceDescriptionFontSize))
                .foregroundColor(Palette.systemGray)
        }
    }

    private func stackView(spacing: CGFloat? = nil, @ViewBuilder content: () -> some View) -> some View {
        Group {
            switch style {
            case .compact:
                HStack(alignment: .center, spacing: spacing) {
                    content()
                }
            case .large:
                VStack(alignment: .center, spacing: spacing) {
                    content()
                }
            }
        }
    }

    private func metrics<T>(compact: T?, large: T?) -> T? {
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
}

// MARK: ProductInfoView.ViewModel

extension ProductInfoView {
    struct ViewModel: Identifiable {
        let id: String
        let title: String
        let description: String
        let price: String
        let priceDescription: String?
    }
}

// MARK: - Constants

private extension CGFloat {
    static let height = value(default: 56, tvOS: 200.0)
    static let padding = value(default: .zero, tvOS: 24.0)
    static let priceDescriptionFontSize = value(default: 10.0)
    static let largeImageHeight = 140.0
    static let largeSpacing = 14.0
}

private extension Int {
    static let lineLimit = 2
}

// MARK: Preview

#if swift(>=5.9)
    #Preview {
        ProductInfoView(
            viewModel: .init(
                id: UUID().uuidString,
                title: "My App Lifetime",
                description: "Lifetime access to additional content",
                price: "$19.99",
                priceDescription: "Every Month"
            ),
            icon: nil,
            style: .compact,
            action: {}
        )
    }
#endif
