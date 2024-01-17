//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class UserDefaultsMock: IUserDefaults {
    var invokedSet = false
    var invokedSetCount = 0
    var invokedSetParameters: (key: String, codable: Any)?
    var invokedSetParametersList = [(key: String, codable: Any)]()

    func set<T: Codable>(key: String, codable: T) {
        invokedSet = true
        invokedSetCount += 1
        invokedSetParameters = (key, codable)
        invokedSetParametersList.append((key, codable))
    }

    var invokedGet = false
    var invokedGetCount = 0
    var invokedGetParameters: (key: String, Void)?
    var invokedGetParametersList = [(key: String, Void)]()
    var stubbedGetResult: Any!

    func get<T: Codable>(key: String) -> T? {
        invokedGet = true
        invokedGetCount += 1
        invokedGetParameters = (key, ())
        invokedGetParametersList.append((key, ()))
        return stubbedGetResult as? T
    }
}
