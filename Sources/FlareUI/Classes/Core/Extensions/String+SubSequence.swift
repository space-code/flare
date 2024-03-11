//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

extension String {
    init?(_ substring: SubSequence?) {
        guard let substring else { return nil }
        self.init(substring)
    }
}
