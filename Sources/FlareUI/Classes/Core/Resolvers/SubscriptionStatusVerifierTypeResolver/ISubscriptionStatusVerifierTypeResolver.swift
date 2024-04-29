//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

protocol ISubscriptionStatusVerifierTypeResolver {
    func resolve(_ type: SubscriptionStatusVerifierType) -> ISubscriptionStatusVerifier?
}
