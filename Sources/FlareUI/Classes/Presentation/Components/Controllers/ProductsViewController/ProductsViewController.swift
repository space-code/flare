//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit
import SwiftUI
#if canImport(UIKit)
    import UIKit
#elseif canImport(Cocoa)
    import Cocoa
#endif

// MARK: - ProductsViewController

@available(watchOS, unavailable)
public final class ProductsViewController: ViewController {
    // MARK: - Properties

    private lazy var viewModel = ProductsViewControllerViewModel()

    private lazy var productsView: HostingController<some View> = {
        let view = ProductsView(ids: self.ids)
            .onInAppPurchaseCompletion(completion: viewModel.onInAppPurchaseCompletion)
            .storeButton(.visible, types: viewModel.visibleStoreButtons)
            .storeButton(.hidden, types: viewModel.hiddenStoreButtons)
            .inAppPurchaseOptions(viewModel.inAppPurchaseOptions)

        return BaseHostingController(rootView: view)
    }()

    private let ids: Set<String>

    public var onInAppPurchaseCompletion: PurchaseCompletionHandler? {
        didSet {
            viewModel.onInAppPurchaseCompletion = onInAppPurchaseCompletion
        }
    }

    // MARK: Initialization

    public init(ids: Set<String>) {
        self.ids = ids
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Private

    private func setupUI() {
        #if os(iOS) || os(tvOS)
            self.view.backgroundColor = Asset.Colors.systemBackground.color
        #endif
        self.add(productsView)
    }

    private func updateStoreButtons(
        _ buttons: inout [StoreButtonType],
        add newButtons: [StoreButtonType],
        remove _: [StoreButtonType]
    ) {
        buttons += newButtons
        buttons = buttons.removingDuplicates()
    }
}

// MARK: - Environments

public extension ProductsViewController {
    func storeButton(_ visibility: StoreButtonVisibility, types: [StoreButtonType]) {
        switch visibility {
        case .visible:
            updateStoreButtons(&viewModel.visibleStoreButtons, add: types, remove: viewModel.hiddenStoreButtons)
            viewModel.hiddenStoreButtons.removeAll { types.contains($0) }
        case .hidden:
            updateStoreButtons(&viewModel.hiddenStoreButtons, add: types, remove: viewModel.visibleStoreButtons)
            viewModel.visibleStoreButtons.removeAll { types.contains($0) }
        }
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func inAppPurchaseOptions(_ options: ((StoreProduct) -> Set<Product.PurchaseOption>?)?) {
        viewModel.inAppPurchaseOptions = { PurchaseOptions(options: options?($0) ?? []) }
    }
}
