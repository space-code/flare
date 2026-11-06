//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public typealias Closure<T> = (T) -> Void
public typealias Closure2<T, U> = (T, U) -> Void

public typealias SendableClosure<T> = @Sendable (T) -> Void
