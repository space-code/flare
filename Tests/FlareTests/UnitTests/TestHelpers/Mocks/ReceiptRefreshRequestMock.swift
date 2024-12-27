//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class ReceiptRefreshRequestMock: IReceiptRefreshRequest, @unchecked Sendable {
    var invokedIdSetter = false
    var invokedIdSetterCount = 0
    var invokedId: String?
    var invokedIdList = [String]()
    var invokedIdGetter = false
    var invokedIdGetterCount = 0
    var stubbedId: String! = ""

    var id: String {
        set {
            invokedIdSetter = true
            invokedIdSetterCount += 1
            invokedId = newValue
            invokedIdList.append(newValue)
        }
        get {
            invokedIdGetter = true
            invokedIdGetterCount += 1
            return stubbedId
        }
    }

    var invokedStart = false
    var invokedStartCount = 0
    var stubbedStartAction: (() -> Void)?

    func start() {
        invokedStart = true
        invokedStartCount += 1
        stubbedStartAction?()
    }
}
