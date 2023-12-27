//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

public enum VerificationError: Swift.Error {
    case unverified(productID: String, error: Error)
}
