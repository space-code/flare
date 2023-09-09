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

extension IAPError: Equatable {
    public static func == (lhs: IAPError, rhs: IAPError) -> Bool {
        switch (lhs, rhs) {
        case (.emptyProducts, .emptyProducts):
            return true
        case let (.invalid(lhs), .invalid(rhs)):
            return lhs == rhs
        case (.paymentNotAllowed, .paymentNotAllowed):
            return true
        case (.paymentCancelled, .paymentCancelled):
            return true
        case (.storeProductNotAvailable, .storeProductNotAvailable):
            return true
        case (.storeTrouble, .storeTrouble):
            return true
        case let (.with(lhs), .with(rhs)):
            return (lhs as NSError) == (rhs as NSError)
        case (.receiptNotFound, .receiptNotFound):
            return true
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
