//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Enumeration representing errors that can occur during verification.
public enum VerificationError: Error {
    // Case for unverified product with associated productID and error details.
    case unverified(productID: String, error: Error)
}
