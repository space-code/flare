//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Type that represents a request to the App Store.
protocol ISKRequest: Hashable {
    /// The request’s identifier.
    var id: String { get }
}
