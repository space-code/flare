//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

extension DateComponentsFormatter {
    static let full: IDateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        formatter.zeroFormattingBehavior = .dropAll
        return formatter
    }()
}
