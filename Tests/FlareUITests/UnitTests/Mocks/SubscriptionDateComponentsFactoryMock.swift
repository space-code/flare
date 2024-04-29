//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
@testable import FlareUI
import Foundation

final class SubscriptionDateComponentsFactoryMock: ISubscriptionDateComponentsFactory {
    var invokedDateComponents = false
    var invokedDateComponentsCount = 0
    var invokedDateComponentsParameters: (subscription: SubscriptionPeriod, Void)?
    var invokedDateComponentsParametersList = [(subscription: SubscriptionPeriod, Void)]()
    var stubbedDateComponentsResult: DateComponents!

    func dateComponents(for subscription: SubscriptionPeriod) -> DateComponents {
        invokedDateComponents = true
        invokedDateComponentsCount += 1
        invokedDateComponentsParameters = (subscription, ())
        invokedDateComponentsParametersList.append((subscription, ()))
        return stubbedDateComponentsResult
    }
}
