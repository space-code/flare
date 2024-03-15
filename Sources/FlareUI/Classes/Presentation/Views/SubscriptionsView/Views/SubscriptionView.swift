//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionView

struct SubscriptionView: View {
    // MARK: Properties

    @Environment(\.subscriptionControlStyle) var subscriptionControlStyle

    @Binding private var isSelected: Bool

    private let viewModel: ViewModel
    private let action: () -> Void

    // MARK: Initialization

    init(viewModel: ViewModel, isSelected: Binding<Bool>, action: @escaping () -> Void) {
        self.viewModel = viewModel
        self._isSelected = isSelected
        self.action = action
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .spacing10px) {
            HStack {
                titleView
                Spacer()
                checkmarkView
            }

            priceView
            separatorView
            descriptionView
        }
        .padding()
        .background(Palette.systemGray5)
        .mask(rectangleBackground)
        .overlay(overlayView)
        .onTapGesture {
            action()
        }
    }

    // MARK: Private

    private var titleView: some View {
        Text(viewModel.title)
            .font(.headline)
            .fontWeight(.bold)
    }

    private var priceView: some View {
        Text(viewModel.price)
            .font(.subheadline)
    }

    private var descriptionView: some View {
        Text(viewModel.description)
            .font(.subheadline)
    }

    private var checkmarkView: some View {
        Image(systemName: isSelected ? .checkmark : .circle)
            .resizable()
            .foregroundColor(isSelected ? .blue : Palette.systemGray2)
            .frame(
                width: CGSize.iconSize.width,
                height: CGSize.iconSize.height
            )
            .background(isSelected ? Color.white : .clear)
            .mask(Circle())
    }

    private var separatorView: some View {
        Rectangle()
            .foregroundColor(Palette.systemGray4)
            .frame(maxWidth: .infinity)
            .frame(height: .separatorHeight)
    }

    private var rectangleBackground: RoundedRectangle {
        RoundedRectangle(cornerSize: .cornerSize)
    }

    private var overlayView: some View {
        rectangleBackground
            .strokeBorder(.blue, lineWidth: 2)
            .opacity((isSelected && subscriptionControlStyle == .prominentPicker) ? 1.0 : .zero)
    }
}

// MARK: SubscriptionView.ViewModel

extension SubscriptionView {
    struct ViewModel: Identifiable, Equatable, Hashable {
        let id: String
        let title: String
        let price: String
        let description: String
    }
}

private extension String {
    static let checkmark = "checkmark.circle.fill"
    static let circle = "circle"
}

private extension CGSize {
    static let cornerSize = CGSize(width: 18, height: 18)
    static let iconSize = CGSize(width: 26, height: 26)
}

private extension CGFloat {
    static let separatorHeight = 1.0
}

#if swift(>=5.9)
    #Preview {
        VStack {
            SubscriptionView(
                viewModel: .init(
                    id: "",
                    title: "Subscription",
                    price: "$0.99/month",
                    description: "Description"
                ),
                isSelected: .constant(true),
                action: {}
            )
            SubscriptionView(
                viewModel: .init(
                    id: "",
                    title: "Subscription",
                    price: "$0.99/month",
                    description: "Description"
                ),
                isSelected: .constant(true),
                action: {}
            )
            .environment(\.subscriptionControlStyle, .prominentPicker)
        }
    }
#endif
