//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import SwiftUI

public final class StoreButtonsAssemblyMock: IStoreButtonsAssembly {
    public init() {}

    public var invokedAssemble = false
    public var invokedAssembleCount = 0
    public var invokedAssembleParameters: (storeButtonType: StoreButtonType, Void)?
    public var invokedAssembleParametersList = [(storeButtonType: StoreButtonType, Void)]()
    public var stubbedAssembleResult: AnyView!

    public func assemble(storeButtonType: StoreButtonType) -> AnyView {
        invokedAssemble = true
        invokedAssembleCount += 1
        invokedAssembleParameters = (storeButtonType, ())
        invokedAssembleParametersList.append((storeButtonType, ()))
        return stubbedAssembleResult
    }
}
