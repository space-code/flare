//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

extension Configuration {
    static func fake(applicationUsername: String = "username") -> Configuration {
        Configuration(applicationUsername: applicationUsername)
    }
}
