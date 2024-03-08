//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductInfoView

struct ProductInfoView: View {
    // MARK: Properties

    private let viewModel: ViewModel
    private let icon: ProductStyleConfiguration.Icon?
    private let action: () -> Void

    // MARK: Initialization

    init(viewModel: ViewModel, icon: ProductStyleConfiguration.Icon?, action: @escaping () -> Void) {
        self.viewModel = viewModel
        self.icon = icon
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
        HStack(alignment: .center) {
            iconView

            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.body)
                Text(viewModel.description)
                    .font(.caption)
                    .foregroundColor(Palette.systemGray)
                #if os(tvOS)
                    Spacer()
                #endif
            }
            Spacer()
            priceView
        }
        .padding(.padding)
        .frame(height: .height)
    }

    private var iconView: some View {
        icon.map { $0 }
    }

    private var priceView: some View {
        #if os(tvOS)
            Text(viewModel.price)
        #else
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
    }
}

// MARK: - Constants

private extension CGFloat {
    static let height = value(default: 56, tvOS: 200.0)
    static let padding = value(default: .zero, tvOS: 24.0)
}

// MARK: Preview

#if swift(>=5.9)
    #Preview {
        ProductInfoView(
            viewModel: .init(
                id: UUID().uuidString,
                title: "My App Lifetime",
                description: "Lifetime access to additional content",
                price: "$19.99"
            ),
            icon: nil,
            action: {}
        )
    }
#endif
