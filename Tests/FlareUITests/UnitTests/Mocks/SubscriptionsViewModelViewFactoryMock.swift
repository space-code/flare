//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
@testable import FlareUI

final class SubscriptionsViewModelViewFactoryMock: ISubscriptionsViewModelViewFactory {
    var invokedMake = false
    var invokedMakeCount = 0
    var invokedMakeParameters: (products: [StoreProduct], Void)?
    var invokedMakeParametersList = [(products: [StoreProduct], Void)]()
    var stubbedMake: [SubscriptionView.ViewModel] = []

    func make(_ products: [StoreProduct]) async throws -> [SubscriptionView.ViewModel] {
        invokedMake = true
        invokedMakeCount += 1
        invokedMakeParameters = (products, ())
        invokedMakeParametersList.append((products, ()))
        return stubbedMake
    }
}
