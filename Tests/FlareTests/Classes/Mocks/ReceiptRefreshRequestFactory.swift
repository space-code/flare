//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import Foundation
import protocol StoreKit.SKRequestDelegate

final class ReceiptRefreshRequestFactoryMock: IReceiptRefreshRequestFactory {
    var invokedMake = false
    var invokedMakeCount = 0
    var invokedMakeParameters: (id: String, delegate: SKRequestDelegate?)?
    var invokedMakeParametersList = [(id: String, delegate: SKRequestDelegate?)]()
    var stubbedMakeResult: IReceiptRefreshRequest!

    func make(id: String, delegate: SKRequestDelegate?) -> IReceiptRefreshRequest {
        invokedMake = true
        invokedMakeCount += 1
        invokedMakeParameters = (id, delegate)
        invokedMakeParametersList.append((id, delegate))
        return stubbedMakeResult
    }
}
