//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

extension Error {
    var iap: IAPError {
        if let error = self as? IAPError {
            return error
        }
        return .with(error: self)
    }
}
