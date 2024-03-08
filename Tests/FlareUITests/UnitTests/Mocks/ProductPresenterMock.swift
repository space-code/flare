//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import Foundation

final class ProductPresenterMock: IProductPresenter {
    func viewDidLoad() {}

    var invokedPurchase = false
    var invokedPurchaseCount = 0
    var invokedPurchaseParameters: (options: PurchaseOptions?, Void)?
    var invokedPurchaseParametersList = [(options: PurchaseOptions?, Void)]()
    var stubbedPurchase: Bool = true

    func purchase(options: PurchaseOptions?) async throws -> Bool {
        invokedPurchase = true
        invokedPurchaseCount += 1
        invokedPurchaseParameters = (options, ())
        invokedPurchaseParametersList.append((options, ()))
        return stubbedPurchase
    }
}
