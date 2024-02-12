//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class EligibilityProviderMock: IEligibilityProvider {
    var invokedCheckEligibility = false
    var invokedCheckEligibilityCount = 0
    var invokedCheckEligibilityParameters: (products: [StoreProduct], Void)?
    var invokedCheckEligibilityParametersList = [(products: [StoreProduct], Void)]()
    var stubbedCheckEligibility: [String: SubscriptionEligibility] = [:]

    func checkEligibility(products: [StoreProduct]) async throws -> [String: SubscriptionEligibility] {
        invokedCheckEligibility = true
        invokedCheckEligibilityCount += 1
        invokedCheckEligibilityParameters = (products, ())
        invokedCheckEligibilityParametersList.append((products, ()))
        return stubbedCheckEligibility
    }
}
