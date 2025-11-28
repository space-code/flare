//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// It encompasses all refund request states.
public enum RefundRequestStatus: Sendable {
    /// A user cancelled the refund request.
    case userCancelled
    /// The request completed successfully.
    case success
    /// The refund request failed with an error.
    case failed(error: Error)
    /// The unknown error occurred.
    case unknown
}
