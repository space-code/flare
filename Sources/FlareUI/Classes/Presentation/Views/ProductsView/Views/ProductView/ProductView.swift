//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductView

struct ProductView: View {
    // MARK: Properties

    private let viewModel: ViewModel
    private let action: () -> Void

    // MARK: Initialization

    init(viewModel: ViewModel, action: @escaping () -> Void) {
        self.viewModel = viewModel
        self.action = action
    }

    // MARK: View

    var body: some View {
        contentView
    }

    // MARK: Private

    private var contentView: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.body)
                Text(viewModel.description)
                    .font(.caption)
                    .foregroundColor(Color(UIColor.systemGray))
            }
            Spacer()
            Button(
                action: {
                    action()
                },
                label: {
                    Text(viewModel.price)
                        .font(.footnote)
                        .fontWeight(.bold)
                }
            )
            .buttonStyle(.bordered)
        }
    }
}

// MARK: ProductView.ViewModel

extension ProductView {
    struct ViewModel: Identifiable {
        let id: String
        let title: String
        let description: String
        let price: String
    }
}

// MARK: Preview

#Preview {
    ProductView(
        viewModel: ProductView.ViewModel(
            id: UUID().uuidString,
            title: "My App Lifetime",
            description: "Lifetime access to additional content",
            price: "$19.99"
        ), action: {}
    )
}
