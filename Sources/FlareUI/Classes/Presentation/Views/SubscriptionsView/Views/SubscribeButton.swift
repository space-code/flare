//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscribeButton

struct SubscribeButton: View {
    // MARK: Properties

    @Environment(\.subscriptionStoreButtonLabel) private var subscriptionStoreButtonLabel
    @Environment(\.tintColor) private var tintColor

    private let viewModel: ViewModel
    private let action: () -> Void

    // MARK: Initialization

    init(viewModel: ViewModel, action: @escaping () -> Void) {
        self.viewModel = viewModel
        self.action = action
    }

    // MARK: View

    var body: some View {
        button
            .padding(.horizontal)
    }

    // MARK: Private

    private var button: some View {
        Button(
            action: {
                action()
            },
            label: {
                labelView
            }
        )
        .buttonStyle(PrimaryButtonStyle())
    }

    private var labelView: some View {
        Group {
            switch subscriptionStoreButtonLabel {
            case .action:
                textView
            case .displayName:
                Text(viewModel.displayName)
                    .font(.body)
                    .fontWeight(.bold)
            case .multiline:
                VStack {
                    textView
                    Text(viewModel.price)
                        .font(.footnote)
                        .fontWeight(.medium)
                }
            case .price:
                Text(viewModel.price)
                    .font(.footnote)
                    .fontWeight(.medium)
            }
        }
    }

    private var textView: some View {
        Text("Subscribe")
            .font(.body)
            .fontWeight(.bold)
            .contrast(tintColor)
    }
}

// MARK: SubscribeButton.ViewModel

extension SubscribeButton {
    struct ViewModel {
        let displayName: String
        let price: String
    }
}

#if swift(>=5.9)
    #Preview {
        VStack {
            SubscribeButton(
                viewModel: .init(
                    displayName: "My App Plus",
                    price: "1 week free, then $19.99/year"
                ), action: {}
            )
            SubscribeButton(
                viewModel: .init(
                    displayName: "My App Plus",
                    price: "1 week free, then $19.99/year"
                ), action: {}
            )
            .environment(\.subscriptionStoreButtonLabel, .displayName)
            SubscribeButton(
                viewModel: .init(
                    displayName: "My App Plus",
                    price: "1 week free, then $19.99/year"
                ), action: {}
            )
            .environment(\.subscriptionStoreButtonLabel, .multiline)
            SubscribeButton(
                viewModel: .init(
                    displayName: "My App Plus",
                    price: "1 week free, then $19.99/year"
                ), action: {}
            )
            .environment(\.subscriptionStoreButtonLabel, .price)
        }
    }
#endif
