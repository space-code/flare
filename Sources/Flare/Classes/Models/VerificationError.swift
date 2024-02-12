//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - VerificationError

/// Enumeration representing errors that can occur during verification.
public enum VerificationError: Error {
    // Case for unverified product with associated productID and error details.
    case unverified(productID: String, error: Error)
}

// MARK: LocalizedError

extension VerificationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .unverified(productID, error):
            return L10n.VerificationError.unverified(productID, error.localizedDescription)
        }
    }
}
