//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation
import protocol StoreKit.SKRequestDelegate

final class ReceiptRefreshRequestFactoryMock: IReceiptRefreshRequestFactory {
    var invokedMake = false
    var invokedMakeCount = 0
    var invokedMakeParameters: (requestID: String, delegate: SKRequestDelegate?)?
    var invokedMakeParametersList = [(requestID: String, delegate: SKRequestDelegate?)]()
    var stubbedMakeResult: IReceiptRefreshRequest!

    func make(requestID: String, delegate: SKRequestDelegate?) -> IReceiptRefreshRequest {
        invokedMake = true
        invokedMakeCount += 1
        invokedMakeParameters = (requestID, delegate)
        invokedMakeParametersList.append((requestID, delegate))
        return stubbedMakeResult
    }
}
