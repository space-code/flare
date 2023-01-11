//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

// MARK: - IAPError

public enum IAPError: Swift.Error {
    case emptyProducts
    case invalid(productIds: [String])
    case paymentNotAllowed
    case paymentCancelled
    case storeProductNotAvailable
    case storeTrouble
    case with(error: Swift.Error)
    case receiptNotFound
    case unknown
}

extension IAPError {
    init(error: Swift.Error?) {
        switch (error as? SKError)?.code {
        case .paymentNotAllowed:
            self = .paymentNotAllowed
        case .paymentCancelled:
            self = .paymentCancelled
        case .storeProductNotAvailable:
            self = .storeProductNotAvailable
        case .unknown:
            self = .storeTrouble
        default:
            if let error = error {
                self = .with(error: error)
            } else {
                self = .unknown
            }
        }
    }
}

extension IAPError {
    var plainError: Error {
        if case let IAPError.with(error) = self {
            return error
        } else {
            return self
        }
    }
}
