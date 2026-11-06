//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

extension SKPaymentQueue: PaymentQueue {
    @objc
    public var canMakePayments: Bool {
        SKPaymentQueue.canMakePayments()
    }
}
