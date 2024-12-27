//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
@testable import FlareUI
import Foundation

public final class SubscriptionsPresenterMock: ISubscriptionsPresenter, @unchecked Sendable {
    public init() {}

    public var invokedViewDidLoad = false
    public var invokedViewDidLoadCount = 0

    public func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
    }

    public var invokedSelectProduct = false
    public var invokedSelectProductCount = 0
    public var invokedSelectProductParameters: (id: String, Void)?
    public var invokedSelectProductParametersList = [(id: String, Void)]()

    public func selectProduct(with id: String) {
        invokedSelectProduct = true
        invokedSelectProductCount += 1
        invokedSelectProductParameters = (id, ())
        invokedSelectProductParametersList.append((id, ()))
    }

    public var invokedProduct = false
    public var invokedProductCount = 0
    public var invokedProductParameters: (id: String, Void)?
    public var invokedProductParametersList = [(id: String, Void)]()
    public var stubbedProductResult: StoreProduct!

    public func product(withID id: String) -> StoreProduct? {
        invokedProduct = true
        invokedProductCount += 1
        invokedProductParameters = (id, ())
        invokedProductParametersList.append((id, ()))
        return stubbedProductResult
    }

    public var invokedSubscribe = false
    public var invokedSubscribeCount = 0
    public var invokedSubscribeParameters: (optionsHandler: PurchaseOptionHandler?, Void)?
    public var invokedSubscribeParametersList = [(optionsHandler: PurchaseOptionHandler?, Void)]()
    public var stubbedSubscribe: StoreTransaction!

    public func subscribe(optionsHandler: PurchaseOptionHandler?) async throws -> StoreTransaction {
        invokedSubscribe = true
        invokedSubscribeCount += 1
        invokedSubscribeParameters = (optionsHandler, ())
        invokedSubscribeParametersList.append((optionsHandler, ()))
        return stubbedSubscribe
    }
}
