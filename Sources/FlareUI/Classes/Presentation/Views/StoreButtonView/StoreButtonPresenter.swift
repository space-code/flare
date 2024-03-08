//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IStoreButtonPresenter

protocol IStoreButtonPresenter {
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func restore() async throws
}

// MARK: - StoreButtonPresenter

final class StoreButtonPresenter: IPresenter {
    // MARK: Properties

    private let iap: IFlare

    weak var viewModel: ViewModel<StoreButtonViewModel>?

    // MARK: Initialization

    init(iap: IFlare) {
        self.iap = iap
    }
}

// MARK: IStoreButtonPresenter

extension StoreButtonPresenter: IStoreButtonPresenter {
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func restore() async throws {
        try await iap.restore()
    }
}
