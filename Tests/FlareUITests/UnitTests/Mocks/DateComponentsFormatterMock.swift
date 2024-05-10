//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import Foundation

final class DateComponentsFormatterMock: IDateComponentsFormatter {
    var invokedAllowedUnitsSetter = false
    var invokedAllowedUnitsSetterCount = 0
    var invokedAllowedUnits: NSCalendar.Unit?
    var invokedAllowedUnitsList = [NSCalendar.Unit]()
    var invokedAllowedUnitsGetter = false
    var invokedAllowedUnitsGetterCount = 0
    var stubbedAllowedUnits: NSCalendar.Unit!

    var allowedUnits: NSCalendar.Unit {
        set {
            invokedAllowedUnitsSetter = true
            invokedAllowedUnitsSetterCount += 1
            invokedAllowedUnits = newValue
            invokedAllowedUnitsList.append(newValue)
        }
        get {
            invokedAllowedUnitsGetter = true
            invokedAllowedUnitsGetterCount += 1
            return stubbedAllowedUnits
        }
    }

    var invokedString = false
    var invokedStringCount = 0
    var invokedStringParameters: (from: DateComponents, Void)?
    var invokedStringParametersList = [(from: DateComponents, Void)]()
    var stubbedStringResult: String!

    func string(from: DateComponents) -> String? {
        invokedString = true
        invokedStringCount += 1
        invokedStringParameters = (from, ())
        invokedStringParametersList.append((from, ()))
        return stubbedStringResult
    }
}
