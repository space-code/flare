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
        HStack(alignment: .center) {
            icon.map { $0 }
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.body)
                Text(viewModel.description)
                    .font(.caption)
                    .foregroundColor(Palette.systemGray)
            }
            Spacer()
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
        }
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
