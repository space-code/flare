//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI

final class StoreButtonAssemblyMock: IStoreButtonAssembly {
    var invokedAssemble = false
    var invokedAssembleCount = 0
    var invokedAssembleParameters: (storeButtonType: StoreButtonType, Void)?
    var invokedAssembleParametersList = [(storeButtonType: StoreButtonType, Void)]()
    var stubbedAssembleResult: ViewWrapper<StoreButtonViewModel, StoreButtonView>!

    func assemble(storeButtonType: StoreButtonType) -> ViewWrapper<StoreButtonViewModel, StoreButtonView> {
        invokedAssemble = true
        invokedAssembleCount += 1
        invokedAssembleParameters = (storeButtonType, ())
        invokedAssembleParametersList.append((storeButtonType, ()))
        return stubbedAssembleResult
    }
}
