//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare

final class RefundProviderMock: IRefundProvider {
    var invokedBeginRefundRequest = false
    var invokedBeginRefundRequestCount = 0
    var invokedBeginRefundRequestParameters: (productID: String, Void)?
    var invokedBeginRefundRequestParametersList = [(productID: String, Void)]()
    var stubbedBeginRefundRequest: RefundRequestStatus!

    func beginRefundRequest(productID: String) async throws -> RefundRequestStatus {
        invokedBeginRefundRequest = true
        invokedBeginRefundRequestCount += 1
        invokedBeginRefundRequestParameters = (productID, ())
        invokedBeginRefundRequestParametersList.append((productID, ()))
        return stubbedBeginRefundRequest
    }
}
