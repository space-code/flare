//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductView

struct ProductView: View {
    // MARK: Properties

    private let viewModel: ViewModel

    // MARK: Initialization

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
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
                Text(viewModel.description)
            }
            Button(
                action: {},
                label: { Text(viewModel.price) }
            )
        }.padding()
    }
}

// MARK: ProductView.ViewModel

extension ProductView {
    struct ViewModel: Identifiable {
        let id: UUID
        let title: String
        let description: String
        let price: String
    }
}

// MARK: Preview

#Preview {
    ProductView(
        viewModel: ProductView.ViewModel(
            id: UUID(),
            title: "My App Lifetime",
            description: "Lifetime access to additional content",
            price: "$19.99"
        )
    )
}
