//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare

final class ReceiptRefreshProviderMock: IReceiptRefreshProvider {
    var invokedReceipt = false
    var invokedReceiptCount = 0
    var stubbedReceipt: String?

    var receipt: String? {
        invokedReceipt = true
        invokedReceiptCount += 1
        return stubbedReceipt
    }

    var invokedRefresh = false
    var invokedRefreshCount = 0
    var invokedRefreshParameters: (requestId: String, handler: ReceiptRefreshHandler)?
    var invokedRefreshParametersList = [(requestId: String, handler: ReceiptRefreshHandler)]()

    func refresh(requestId: String, handler: @escaping ReceiptRefreshHandler) {
        invokedRefresh = true
        invokedRefreshCount += 1
        invokedRefreshParameters = (requestId, handler)
        invokedRefreshParametersList.append((requestId, handler))
    }

    var invokedAsyncRefresh = false
    var invokedAsyncRefreshCount = 0
    var invokedAsyncRefreshParameters: (requestID: String, Void)?
    var invokedAsyncRefreshParametersList = [(requestID: String, Void)]()

    func refresh(requestId: String) async throws {
        invokedAsyncRefresh = true
        invokedAsyncRefreshCount += 1
        invokedAsyncRefreshParameters = (requestId, ())
        invokedAsyncRefreshParametersList.append((requestId, ()))
    }
}
