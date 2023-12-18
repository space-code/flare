//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKitTest

// MARK: - ISKTestSession

protocol ISKTestSession {}

// MARK: - SKTestSession + ISKTestSession

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, visionOS 1.0, *)
extension SKTestSession: ISKTestSession {}
