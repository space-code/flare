//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - IDateComponentsFormatter

/// A type that creates string representations of quantities of time.
protocol IDateComponentsFormatter: Sendable {
    /// The bitmask of calendrical units such as day and month to include in the output string.
    var allowedUnits: NSCalendar.Unit { get set }

    /// Returns a formatted string based on the specified date component information.
    ///
    /// - Parameter from: A date components object containing the date and time information to format.
    ///
    /// - Returns: A formatted string representing the specified date information.
    func string(from: DateComponents) -> String?
}

// MARK: - DateComponentsFormatter + IDateComponentsFormatter

extension DateComponentsFormatter: IDateComponentsFormatter {}
