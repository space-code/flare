//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - PickerSubscriptionStoreControlStyleView

@available(iOS 13.0, macOS 10.15, watchOS 7.0, *)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
struct PickerSubscriptionStoreControlStyleView: View {
    // MARK: Properties

    @Environment(\.subscriptionPickerItemBackground) private var background
    @Environment(\.subscriptionViewTint) private var tintColor

    private let configuration: ISubscriptionControlStyle.Configuration

    // MARK: Initialization

    init(configuration: ISubscriptionControlStyle.Configuration) {
        self.configuration = configuration
    }

    // MARK: View

    var body: some View {
        contentView
        #if os(iOS) || os(macOS) || os(watchOS)
        .onTapGesture {
            configuration.trigger()
        }
        #endif
    }

    // MARK: Private

    private var contentView: some View {
        VStack(alignment: .leading, spacing: .spacing10px) {
            HStack {
                VStack(alignment: .leading, spacing: 8.0) {
                    if configuration.isActive {
                        planView
                    }
                    configuration.label
                        .font(.headline)
                }
                Spacer()
                checkmarkView
            }

            configuration.price
                .font(.subheadline)
            separatorView
            configuration.description
                .font(.subheadline)
        }
        .padding()
        .background(background)
        .mask(rectangleBackground)
    }

    private var checkmarkView: some View {
        ImageView(
            systemName: configuration.isSelected ? .checkmark : .circle,
            defaultImage: configuration.isSelected ? Media.Media.checkmark.swiftUIImage : Media.Media.circle.swiftUIImage
        )
        .foregroundColor(configuration.isSelected ? tintColor : Palette.systemGray2.opacity(0.7))
        .frame(
            width: CGSize.iconSize.width,
            height: CGSize.iconSize.height
        )
        .background(configuration.isSelected ? Color.white : .clear)
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

    private var planView: some View {
        HStack(spacing: 4.0) {
            ImageView(systemName: .star, defaultImage: Media.Media.star.swiftUIImage)
                .frame(
                    width: CGSize.planImageSize.width,
                    height: CGSize.planImageSize.height
                )
                .foregroundColor(tintColor)
            Text(L10n.Common.Subscription.Status.yourPlan.uppercased())
                .font(.caption.weight(.bold))
                .foregroundColor(Palette.systemGray)
        }
    }
}

// MARK: - Preview

#if swift(>=5.9) && os(iOS)
    #Preview {
        PickerSubscriptionStoreControlStyleView(
            configuration: .init(
                label: .init(Text("Name").eraseToAnyView()),
                description: .init(Text("Name").eraseToAnyView()),
                price: .init(Text("Name").eraseToAnyView()),
                isSelected: true,
                isActive: true,
                action: {}
            )
        )
    }
#endif

// MARK: - Constants

private extension String {
    static let checkmark = "checkmark.circle.fill"
    static let circle = "circle"
    static let star = "star"
}

private extension CGSize {
    static let cornerSize = CGSize(width: 18, height: 18)
    static let iconSize = CGSize(width: 26, height: 26)
    static let planImageSize = CGSize(width: 14, height: 14)
}

private extension CGFloat {
    static let separatorHeight = 1.0
}
