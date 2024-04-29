//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - StoreUnavaliableView

struct StoreUnavaliableView: View {
    // MARK: Types

    enum ProductType {
        case product
        case subscription

        var message: String {
            switch self {
            case .product:
                return L10n.StoreUnavailable.Product.message
            case .subscription:
                return L10n.StoreUnavailable.Subscription.message
            }
        }
    }

    // MARK: Properties

    private let productType: ProductType

    // MARK: Initialization

    init(productType: ProductType) {
        self.productType = productType
    }

    // MARK: View

    var body: some View {
        VStack {
            Text(L10n.StoreUnavailable.title)
                .font(.title)
            Text(productType.message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(Palette.systemGray)
        }
        .padding()
    }
}

#if swift(>=5.9)
    #Preview {
        StoreUnavaliableView(productType: .product)
    }
#endif
