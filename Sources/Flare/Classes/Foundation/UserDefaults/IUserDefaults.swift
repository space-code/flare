//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

protocol IUserDefaults {
    func set<T: Codable>(key: String, codable: T)
    func get<T: Codable>(key: String) -> T?
}
