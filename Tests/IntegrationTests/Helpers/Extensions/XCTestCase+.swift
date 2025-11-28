//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import XCTest

extension XCTestCase {
    func value<U>(for closure: () async throws -> U) async -> U? {
        do {
            let value = try await closure()
            return value
        } catch {
            return nil
        }
    }

    func error<T: Error>(for closure: () async throws -> some Any) async -> T? {
        do {
            _ = try await closure()
            return nil
        } catch {
            return error as? T
        }
    }

    func result<U, T: Error>(for closure: () async throws -> U) async -> Result<U, T> {
        do {
            let value = try await closure()
            return .success(value)
        } catch {
            return .failure(error as! T)
        }
    }
}
