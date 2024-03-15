//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import Foundation

public final class ProductsPresenterMock: IProductsPresenter {
    public init() {}

    public var invokedViewDidLoad = false
    public var invokedViewDidLoadCount = 0

    public func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
    }
}
