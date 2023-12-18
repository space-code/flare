//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.2, *)
enum AsyncHandler {
    static func call<T>(
        completion: @escaping (Result<T, Error>) -> Void,
        asyncMethod method: @escaping () async throws -> T
    ) {
        _ = Task<Void, Never> {
            do {
                try completion(.success(await method()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
