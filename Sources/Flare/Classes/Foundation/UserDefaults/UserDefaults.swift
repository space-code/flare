//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

extension UserDefaults: IUserDefaults {
    func set(key: String, codable: some Codable) {
        guard let value = try? JSONEncoder().encode(codable) else { return }
        set(value, forKey: key)
    }

    func get<T: Codable>(key: String) -> T? {
        let data = object(forKey: key) as? Data
        guard let data, let value = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return value
    }
}
