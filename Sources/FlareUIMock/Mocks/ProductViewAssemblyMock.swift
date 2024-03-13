//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
@testable import FlareUI
import Foundation

public final class ProductViewAssemblyMock: IProductViewAssembly {
    public init() {}

    public var invokedAssembleId = false
    public var invokedAssembleIdCount = 0
    public var invokedAssembleIdParameters: (id: String, Void)?
    public var invokedAssembleIdParametersList = [(id: String, Void)]()
    public var stubbedAssembleIdResult: ViewWrapper<ProductViewModel, ProductWrapperView>!

    public func assemble(id: String) -> ViewWrapper<ProductViewModel, ProductWrapperView> {
        invokedAssembleId = true
        invokedAssembleIdCount += 1
        invokedAssembleIdParameters = (id, ())
        invokedAssembleIdParametersList.append((id, ()))
        return stubbedAssembleIdResult
    }

    public var invokedAssembleStoreProduct = false
    public var invokedAssembleStoreProductCount = 0
    public var invokedAssembleStoreProductParameters: (storeProduct: StoreProduct, Void)?
    public var invokedAssembleStoreProductParametersList = [(storeProduct: StoreProduct, Void)]()
    public var stubbedAssembleStoreProductResult: ViewWrapper<ProductViewModel, ProductWrapperView>!

    public func assemble(storeProduct: StoreProduct) -> ViewWrapper<ProductViewModel, ProductWrapperView> {
        invokedAssembleStoreProduct = true
        invokedAssembleStoreProductCount += 1
        invokedAssembleStoreProductParameters = (storeProduct, ())
        invokedAssembleStoreProductParametersList.append((storeProduct, ()))
        return stubbedAssembleStoreProductResult
    }
}
