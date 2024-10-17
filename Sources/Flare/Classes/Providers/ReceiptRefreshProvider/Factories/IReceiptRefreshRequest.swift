//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// A type that represents a receipt refresh request.
protocol IReceiptRefreshRequest {
    /// The request's identifier.
    var id: String { get set }

    /// Performs receipt refreshing logic.
    func start()
}
