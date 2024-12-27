//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - IStorePayment

protocol IStorePayment: AnyObject, Sendable {
    var productIdentifier: String { get }
}
