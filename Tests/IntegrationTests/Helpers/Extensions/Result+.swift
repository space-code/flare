//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

extension Result {
    var error: Failure? {
        switch self {
        case let .failure(error):
            error
        default:
            nil
        }
    }

    var success: Success? {
        switch self {
        case let .success(value):
            value
        default:
            nil
        }
    }
}
