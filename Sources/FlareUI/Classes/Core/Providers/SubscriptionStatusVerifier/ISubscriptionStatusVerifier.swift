//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

public protocol ISubscriptionStatusVerifier {
    func validate(_ storeProduct: StoreProduct) async throws -> Bool
}
