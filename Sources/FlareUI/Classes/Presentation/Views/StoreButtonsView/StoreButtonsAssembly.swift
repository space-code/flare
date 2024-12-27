//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - IStoreButtonsAssembly

protocol IStoreButtonsAssembly {
    @MainActor
    func assemble(storeButtonType: StoreButtonType) -> AnyView
}

// MARK: - StoreButtonsAssembly

@available(watchOS, unavailable)
final class StoreButtonsAssembly: IStoreButtonsAssembly {
    // MARK: Properties

    private let storeButtonAssembly: IStoreButtonAssembly
    private let policiesButtonAssembly: IPoliciesButtonAssembly

    // MARK: Initialization

    init(storeButtonAssembly: IStoreButtonAssembly, policiesButtonAssembly: IPoliciesButtonAssembly) {
        self.storeButtonAssembly = storeButtonAssembly
        self.policiesButtonAssembly = policiesButtonAssembly
    }

    // MARK: IStoreButtonsAssembly

    @MainActor
    func assemble(storeButtonType: StoreButtonType) -> AnyView {
        switch storeButtonType {
        case .restore:
            return Group {
                if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *) {
                    storeButtonAssembly.assemble(storeButtonType: .restore)
                }
            }.eraseToAnyView()
        case .policies:
            return policiesButtonAssembly.assemble().eraseToAnyView()
        }
    }
}
