//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

final class ProductsRequest: ISKRequest {
    // MARK: Properties

    private let request: SKRequest

    var id: String { request.id }

    // MARK: Initialization

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
