//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

// MARK: - IAPError

/// `IAPError` is the error type returned by Flare.
/// It encompasses a few different types of errors, each with their own associated reasons.
public enum IAPError: Swift.Error {
    /// The attempt to fetch products with invalid identifiers.
    case invalid(productIDs: [String])
    /// The attempt to purchase a product when payments are not allowed.
    case paymentNotAllowed
    /// The payment was cancelled.
    case paymentCancelled
    /// The attempt to fetch a product that doesn't available.
    case storeProductNotAvailable
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
    /// The purchase is pending, and requires action from the customer.
    ///
    /// - Note: This is only available for StoreKit 2 transactions.
    case paymentDefferred
    /// The decoding signature is failed.
    ///
    /// - Note: This is only available for StoreKit 2 transactions.
    case failedToDecodeSignature(signature: String)
    /// The unknown error occurred.
    case unknown
}

extension IAPError {
    init(error: Swift.Error?) {
        if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *) {
            if let storeKitError = error as? StoreKitError {
                self.init(storeKitError: storeKitError)
            } else {
                self.init(error)
            }
        } else {
            self.init(error)
        }
    }

    @available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
    private init(storeKitError: StoreKit.StoreKitError) {
        switch storeKitError {
        case .unknown:
            self = .unknown
        case .userCancelled:
            self = .paymentCancelled
        default:
            self = .with(error: storeKitError)
        }
    }

    private init(_ error: Swift.Error?) {
        switch (error as? SKError)?.code {
        case .paymentNotAllowed:
            self = .paymentNotAllowed
        case .paymentCancelled:
            self = .paymentCancelled
        case .storeProductNotAvailable:
            self = .storeProductNotAvailable
        case .unknown:
            self = .unknown
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

extension IAPError: Equatable {
    public static func == (lhs: IAPError, rhs: IAPError) -> Bool {
        switch (lhs, rhs) {
        case let (.invalid(lhs), .invalid(rhs)):
            return lhs == rhs
        case (.paymentNotAllowed, .paymentNotAllowed):
            return true
        case (.paymentCancelled, .paymentCancelled):
            return true
        case (.storeProductNotAvailable, .storeProductNotAvailable):
            return true
        case let (.with(lhs), .with(rhs)):
            return (lhs as NSError) == (rhs as NSError)
        case (.receiptNotFound, .receiptNotFound):
            return true
        case let (.refund(lhs), .refund(rhs)):
            return lhs == rhs
        case (.unknown, .unknown):
            return true
        case let (.failedToDecodeSignature(lhs), .failedToDecodeSignature(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}

// MARK: LocalizedError

extension IAPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .invalid(productIDs):
            return L10n.Error.InvalidProductIds.description(productIDs)
        case .paymentNotAllowed:
            return L10n.Error.PaymentNotAllowed.description
        case .paymentCancelled:
            return L10n.Error.PaymentCancelled.description
        case .storeProductNotAvailable:
            return L10n.Error.StoreProductNotAvailable.description
        case let .with(error):
            return L10n.Error.With.description(error.localizedDescription)
        case .receiptNotFound:
            return L10n.Error.Receipt.description
        case let .transactionNotFound(productID):
            return L10n.Error.TransactionNotFound.description(productID)
        case let .refund(error):
            return L10n.Error.Refund.description(error.localizedDescription)
        case let .verification(error):
            return L10n.Error.Verification.description(error.localizedDescription)
        case .paymentDefferred:
            return L10n.Error.PaymentDefferred.description
        case let .failedToDecodeSignature(signature):
            return L10n.Error.FailedToDecodeSignature.description(signature)
        case .unknown:
            return L10n.Error.Unknown.description
        }
    }

    public var failureReason: String? {
        switch self {
        case .paymentNotAllowed:
            return L10n.Error.PaymentNotAllowed.failureReason
        default:
            return nil
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .paymentNotAllowed:
            return L10n.Error.PaymentNotAllowed.recoverySuggestion
        case .storeProductNotAvailable:
            return L10n.Error.StoreProductNotAvailable.recoverySuggestion
        default:
            return nil
        }
    }
}
