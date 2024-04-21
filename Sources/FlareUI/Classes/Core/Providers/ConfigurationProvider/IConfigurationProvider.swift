//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

protocol IConfigurationProvider {
    var subscriptionVerifierType: SubscriptionStatusVerifierType? { get }

    func configure(with configuration: UIConfiguration)
}
