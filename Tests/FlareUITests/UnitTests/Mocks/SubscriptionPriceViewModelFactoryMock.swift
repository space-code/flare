//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
@testable import FlareUI

final class SubscriptionPriceViewModelFactoryMock: ISubscriptionPriceViewModelFactory {
    var invokedMake = false
    var invokedMakeCount = 0
    var invokedMakeParameters: (product: StoreProduct, format: PriceDisplayFormat)?
    var invokedMakeParametersList = [(product: StoreProduct, format: PriceDisplayFormat)]()
    var stubbedMakeResult: String! = ""

    func make(_ product: StoreProduct, format: PriceDisplayFormat) -> String {
        invokedMake = true
        invokedMakeCount += 1
        invokedMakeParameters = (product, format)
        invokedMakeParametersList.append((product, format))
        return stubbedMakeResult
    }

    var invokedPeriod = false
    var invokedPeriodCount = 0
    var invokedPeriodParameters: (product: StoreProduct, Void)?
    var invokedPeriodParametersList = [(product: StoreProduct, Void)]()
    var stubbedPeriodResult: String!

    func period(from product: StoreProduct) -> String? {
        invokedPeriod = true
        invokedPeriodCount += 1
        invokedPeriodParameters = (product, ())
        invokedPeriodParametersList.append((product, ()))
        return stubbedPeriodResult
    }
}
