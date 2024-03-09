//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import Foundation

public final class ProductPresenterMock: IProductPresenter {
    public init() {}

    public func viewDidLoad() {}

    public var invokedPurchase = false
    public var invokedPurchaseCount = 0
    public var invokedPurchaseParameters: (options: PurchaseOptions?, Void)?
    public var invokedPurchaseParametersList = [(options: PurchaseOptions?, Void)]()
    public var stubbedPurchase: Bool = true

    public func purchase(options: PurchaseOptions?) async throws -> Bool {
        invokedPurchase = true
        invokedPurchaseCount += 1
        invokedPurchaseParameters = (options, ())
        invokedPurchaseParametersList.append((options, ()))
        return stubbedPurchase
    }
}
