//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI

public final class StoreButtonAssemblyMock: IStoreButtonAssembly {
    public init() {}

    public var invokedAssemble = false
    public var invokedAssembleCount = 0
    public var invokedAssembleParameters: (storeButtonType: StoreButtonType, Void)?
    public var invokedAssembleParametersList = [(storeButtonType: StoreButtonType, Void)]()
    public var stubbedAssembleResult: ViewWrapper<StoreButtonViewModel, StoreButtonView>!

    public func assemble(storeButtonType: StoreButtonType) -> ViewWrapper<StoreButtonViewModel, StoreButtonView> {
        invokedAssemble = true
        invokedAssembleCount += 1
        invokedAssembleParameters = (storeButtonType, ())
        invokedAssembleParametersList.append((storeButtonType, ()))
        return stubbedAssembleResult
    }
}
