//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
@testable import FlareUI
import Foundation

final class ProductViewAssemblyMock: IProductViewAssembly {
    var invokedAssembleId = false
    var invokedAssembleIdCount = 0
    var invokedAssembleIdParameters: (id: String, Void)?
    var invokedAssembleIdParametersList = [(id: String, Void)]()
    var stubbedAssembleIdResult: ViewWrapper<ProductViewModel, ProductView>!

    func assemble(id: String) -> ViewWrapper<ProductViewModel, ProductView> {
        invokedAssembleId = true
        invokedAssembleIdCount += 1
        invokedAssembleIdParameters = (id, ())
        invokedAssembleIdParametersList.append((id, ()))
        return stubbedAssembleIdResult
    }

    var invokedAssembleStoreProduct = false
    var invokedAssembleStoreProductCount = 0
    var invokedAssembleStoreProductParameters: (storeProduct: StoreProduct, Void)?
    var invokedAssembleStoreProductParametersList = [(storeProduct: StoreProduct, Void)]()
    var stubbedAssembleStoreProductResult: ViewWrapper<ProductViewModel, ProductView>!

    func assemble(storeProduct: StoreProduct) -> ViewWrapper<ProductViewModel, ProductView> {
        invokedAssembleStoreProduct = true
        invokedAssembleStoreProductCount += 1
        invokedAssembleStoreProductParameters = (storeProduct, ())
        invokedAssembleStoreProductParametersList.append((storeProduct, ()))
        return stubbedAssembleStoreProductResult
    }
}
