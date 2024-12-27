//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - AsyncHandler

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.2, *)
enum AsyncHandler {
    static func call<T: Sendable>(
        strategy: Strategy = .default,
        completion: @escaping @Sendable (Result<T, Error>) -> Void,
        asyncMethod method: @escaping @Sendable () async throws -> T
    ) {
        Task {
            do {
                let result = try await method()
                await execute(strategy: strategy) { completion(.success(result)) }
            } catch {
                await execute(strategy: strategy) { completion(.failure(error)) }
            }
        }
    }

    // MARK: Private

    private static func execute(strategy: Strategy, block: @escaping @Sendable () -> Void) async {
        switch strategy {
        case .runOnMain:
            await MainActor.run { block() }
        case .default:
            block()
        }
    }
}

// MARK: AsyncHandler.Strategy

extension AsyncHandler {
    enum Strategy {
        case runOnMain
        case `default`
    }
}
