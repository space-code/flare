//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionView

struct SubscriptionView: View {
    // MARK: Properties

    @Environment(\.subscriptionControlStyle) private var subscriptionControlStyle

    @Binding private var isSelected: Bool

    private let viewModel: ViewModel
    private let action: () -> Void

    // MARK: Initialization

    init(
        viewModel: ViewModel,
        isSelected: Binding<Bool>,
        action: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self._isSelected = isSelected
        self.action = action
    }

    var body: some View {
        subscriptionControlStyle.makeBody(
            configuration: .init(
                label: .init(titleView),
                description: .init(descriptionView),
                price: .init(priceView),
                isSelected: isSelected,
                isActive: viewModel.isActive,
                action: action
            )
        )
    }

    private var titleView: some View {
        Text(viewModel.title)
    }

    private var descriptionView: some View {
        Text(viewModel.description)
    }

    private var priceView: some View {
        Text(viewModel.price)
    }
}

// MARK: SubscriptionView.ViewModel

extension SubscriptionView {
    struct ViewModel: Identifiable, Equatable, Hashable {
        let id: String
        let title: String
        let price: String
        let description: String
        let isActive: Bool
    }
}

#if swift(>=5.9) && os(iOS)
    #Preview {
        VStack {
            SubscriptionView(
                viewModel: .init(
                    id: "",
                    title: "Subscription",
                    price: "$0.99/month",
                    description: "Description",
                    isActive: true
                ),
                isSelected: .constant(true),
                action: {}
            )
            SubscriptionView(
                viewModel: .init(
                    id: "",
                    title: "Subscription",
                    price: "$0.99/month",
                    description: "Description",
                    isActive: false
                ),
                isSelected: .constant(true),
                action: {}
            )
            .subscriptionControlStyle(.prominentPicker)
            .subscriptionViewTint(.green)
            .subscriptionPickerItemBackground(Palette.systemGray5)
        }
    }
#endif
