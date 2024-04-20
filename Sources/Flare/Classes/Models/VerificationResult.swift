//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public enum VerificationResult<SignedType> {
    case verified(SignedType)
    case unverified(SignedType, Error)
}
