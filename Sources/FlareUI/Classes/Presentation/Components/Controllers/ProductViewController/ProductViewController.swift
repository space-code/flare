//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit
import SwiftUI

// MARK: - ProductViewController

@available(watchOS, unavailable)
public final class ProductViewController: ViewController {
    // MARK: - Properties

    private lazy var viewModel = ProductViewControllerViewModel()

    private lazy var productView: HostingController<some View> = {
        let view = ProductView(id: self.id)
            .onInAppPurchaseCompletion(completion: viewModel.onInAppPurchaseCompletion)
            .inAppPurchaseOptions(viewModel.inAppPurchaseOptions)
            .productViewStyle(viewModel.productStyle)

        return BaseHostingController(rootView: view)
    }()

    private let id: String

    public var onInAppPurchaseCompletion: PurchaseCompletionHandler? {
        didSet {
            viewModel.onInAppPurchaseCompletion = onInAppPurchaseCompletion
        }
    }

    public var productStyle: any IProductStyle = CompactProductStyle() {
        didSet {
            viewModel.productStyle = AnyProductStyle(style: productStyle)
        }
    }

    // MARK: Initialization

    public init(id: String) {
        self.id = id
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
        self.add(productView)
    }
}

// MARK: - Environments

public extension ProductViewController {
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func inAppPurchaseOptions(_ options: ((StoreProduct) -> Set<Product.PurchaseOption>?)?) {
        viewModel.inAppPurchaseOptions = { PurchaseOptions(options: options?($0) ?? []) }
    }
}
