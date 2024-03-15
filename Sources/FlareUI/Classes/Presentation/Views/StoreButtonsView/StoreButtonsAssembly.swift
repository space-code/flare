//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - IStoreButtonsAssembly

protocol IStoreButtonsAssembly {
    func assemble(storeButtonType: StoreButtonType) -> AnyView
}

// MARK: - StoreButtonsAssembly

final class StoreButtonsAssembly: IStoreButtonsAssembly {
    private let storeButtonAssembly: IStoreButtonAssembly
    private let policiesButtonAssembly: IPoliciesButtonAssembly

    init(storeButtonAssembly: IStoreButtonAssembly, policiesButtonAssembly: IPoliciesButtonAssembly) {
        self.storeButtonAssembly = storeButtonAssembly
        self.policiesButtonAssembly = policiesButtonAssembly
    }

    func assemble(storeButtonType: StoreButtonType) -> AnyView {
        switch storeButtonType {
        case .restore:
            Group {
                if #available(iOS 15.0, *) {
                    storeButtonAssembly.assemble(storeButtonType: .restore)
                }
            }.eraseToAnyView()
        case .policies:
            policiesButtonAssembly.assemble().eraseToAnyView()
        }
    }
}
