//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - RefundError

/// It encompasses all types of refund errors.
public enum RefundError: Error, Equatable {
    /// The duplicate refund request.
    case duplicateRequest
    /// The refund request failed.
    case failed
}

// MARK: LocalizedError

extension RefundError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .duplicateRequest:
            return L10n.RefundError.DuplicateRequest.description
        case .failed:
            return L10n.RefundError.Failed.description
        }
    }
}
