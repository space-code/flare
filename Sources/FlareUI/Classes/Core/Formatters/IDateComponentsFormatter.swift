//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - IDateComponentsFormatter

protocol IDateComponentsFormatter {
    var allowedUnits: NSCalendar.Unit { get set }

    func string(from: DateComponents) -> String?
}

// MARK: - DateComponentsFormatter + IDateComponentsFormatter

extension DateComponentsFormatter: IDateComponentsFormatter {}
