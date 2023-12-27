//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

// MARK: - IAPError

/// `IAPError` is the error type returned by Flare.
/// It encompasses a few different types of errors, each with their own associated reasons.
public enum IAPError: Swift.Error {
    /// The empty array of products were fetched.
    case emptyProducts
    /// The attempt to fetch products with invalid identifiers.
    case invalid(productIds: [String])
    /// The attempt to purchase a product when payments are not allowed.
    case paymentNotAllowed
    /// The payment was cancelled.
    case paymentCancelled
    /// The attempt to fetch a product that doesn't available.
    case storeProductNotAvailable
    /// The `SKPayment` returned unknown error.
    case storeTrouble
    /// The operation failed with an underlying error.
    case with(error: Swift.Error)
    /// The App Store receipt wasn't found.
    case receiptNotFound
    /// The transaction wasn't found.
    case transactionNotFound(productID: String)
    /// The refund error.
    case refund(error: RefundError)
    /// The verification error.
    ///
    /// - Note: This is only available for StoreKit 2 transactions.
    case verification(error: VerificationError)
    ///
    ///
    /// - Note: This is only available for StoreKit 2 transactions.
    case paymentDefferred
    /// The unknown error occurred.
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

// MARK: Equatable

// swiftlint:disable cyclomatic_complexity
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
        case let (.refund(lhs), .refund(rhs)):
            return lhs == rhs
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}

// swiftlint:enable cyclomatic_complexity
