//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class CacheProviderMock: ICacheProvider {
    var invokedRead = false
    var invokedReadCount = 0
    var invokedReadParameters: (key: String, Void)?
    var invokedReadParametersList = [(key: String, Void)]()
    var stubbedReadResult: Any!

    func read<T: Codable>(key: String) -> T? {
        invokedRead = true
        invokedReadCount += 1
        invokedReadParameters = (key, ())
        invokedReadParametersList.append((key, ()))
        return stubbedReadResult as? T
    }

    var invokedWrite = false
    var invokedWriteCount = 0
    var invokedWriteParameters: (key: String, value: Any)?
    var invokedWriteParametersList = [(key: String, value: Any)]()

    func write(key: String, value: some Codable) {
        invokedWrite = true
        invokedWriteCount += 1
        invokedWriteParameters = (key, value)
        invokedWriteParametersList.append((key, value))
    }
}
