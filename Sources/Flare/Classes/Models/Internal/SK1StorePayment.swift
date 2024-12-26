//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - SK1StorePayment

final class SK1StorePayment: @unchecked Sendable {
    // MARK: Properties

    let underlyingProduct: SKPayment

    // MARK: Initialization

    init(underlyingProduct: SKPayment) {
        self.underlyingProduct = underlyingProduct
    }
}

// MARK: IStorePayment

extension SK1StorePayment: IStorePayment {
    var productIdentifier: String {
        underlyingProduct.productIdentifier
    }
}
