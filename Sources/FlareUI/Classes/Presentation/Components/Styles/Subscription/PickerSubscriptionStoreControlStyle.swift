//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - PickerSubscriptionStoreControlStyle

@available(iOS 13.0, macOS 10.15, watchOS 7.0, *)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
public struct PickerSubscriptionStoreControlStyle: ISubscriptionControlStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: .spacing10px) {
            HStack {
                configuration.label
                    .font(.headline)
                Spacer()
                checkmarkView(confugration: configuration)
            }

            configuration.price
                .font(.subheadline)
            separatorView
            configuration.description
                .font(.subheadline)
        }
        .padding()
        .background(configuration.subscriptionPickerItemBackground)
        .mask(rectangleBackground)
//        .onTapGesture {
//            configuration.trigger()
//        }
    }

    // MARK: Private

    private func checkmarkView(confugration: Configuration) -> some View {
        Image(systemName: confugration.isSelected ? .checkmark : .circle)
            .resizable()
            .foregroundColor(confugration.isSelected ? confugration.subscriptionViewTint : Palette.systemGray2.opacity(0.7))
            .frame(
                width: CGSize.iconSize.width,
                height: CGSize.iconSize.height
            )
            .background(confugration.isSelected ? Color.white : .clear)
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
}

// MARK: - Constants

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

#if swift(>=5.9) && os(iOS)
    #Preview {
        PickerSubscriptionStoreControlStyle().makeBody(
            configuration: .init(
                label: .init(Text("Name").eraseToAnyView()),
                description: .init(Text("Name").eraseToAnyView()),
                price: .init(Text("Name").eraseToAnyView()),
                isSelected: true,
                subscriptionPickerItemBackground: Palette.systemGray5,
                subscriptionViewTint: .green,
                action: {}
            )
        )
    }
#endif
