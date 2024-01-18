//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

/// A class that represents a request to the App Store.
final class ProductsRequest: ISKRequest {
    // MARK: Properties

    /// The request.
    private let request: SKRequest

    /// The request’s identifier.
    var id: String { request.id }

    // MARK: Initialization

    /// Creates a `ProductsRequest` instance.
    ///
    /// - Parameter request: The request.
    init(_ request: SKRequest) {
        self.request = request
    }

    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // MARK: Equatable

    static func == (lhs: ProductsRequest, rhs: ProductsRequest) -> Bool {
        lhs.id == rhs.id
    }
}
