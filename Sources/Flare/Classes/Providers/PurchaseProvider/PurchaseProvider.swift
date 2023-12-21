//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

// MARK: - PurchaseProvider

final class PurchaseProvider {
    // MARK: Properties

    private let paymentProvider: IPaymentProvider

    // MARK: Initialization

    init(paymentProvider: IPaymentProvider) {
        self.paymentProvider = paymentProvider
    }
}

// MARK: IPurchaseProvider

extension PurchaseProvider: IPurchaseProvider {
    func purchase(product _: StoreProduct, completion _: @escaping () -> Void) {}
}
