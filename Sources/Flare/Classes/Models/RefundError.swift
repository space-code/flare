//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// It encompasses all types of refund errors.
public enum RefundError: Error, Equatable {
    /// The duplicate refund request.
    case duplicateRequest
    /// The refund request failed.
    case failed
}
