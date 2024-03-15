//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Concurrency
import Foundation
import StoreKit

/// The package's dependencies.
final class FlareDependencies: IFlareDependencies {
    // MARK: Internal

    lazy var iapProvider: IIAPProvider = IAPProvider(
        paymentQueue: SKPaymentQueue.default(),
        productProvider: sortingProductProviderDecorator,
        purchaseProvider: purchaseProvider,
        receiptRefreshProvider: receiptRefreshProvider,
        refundProvider: refundProvider,
        eligibilityProvider: eligibilityProvider,
        redeemCodeProvider: redeemCodeProvider
    )

    lazy var configurationProvider: IConfigurationProvider = ConfigurationProvider()

    // MARK: Private

    private var sortingProductProviderDecorator: ISortingProductsProviderDecorator {
        SortingProductsProviderDecorator(
            productProvider: cachingProductProviderDecorator
        )
    }

    private var cachingProductProviderDecorator: ICachingProductsProviderDecorator {
        CachingProductsProviderDecorator(
            productProvider: productProvider,
            configurationProvider: configurationProvider
        )
    }

    private var productProvider: IProductProvider {
        ProductProvider(
            dispatchQueueFactory: DispatchQueueFactory()
        )
    }

    private var purchaseProvider: IPurchaseProvider {
        PurchaseProvider(
            paymentProvider: paymentProvider,
            configurationProvider: configurationProvider
        )
    }

    private var paymentProvider: IPaymentProvider {
        PaymentProvider(
            paymentQueue: SKPaymentQueue.default(),
            dispatchQueueFactory: DispatchQueueFactory()
        )
    }

    private var receiptRefreshProvider: IReceiptRefreshProvider {
        ReceiptRefreshProvider(
            dispatchQueueFactory: DispatchQueueFactory(),
            receiptRefreshRequestFactory: ReceiptRefreshRequestFactory()
        )
    }

    private var refundProvider: IRefundProvider {
        RefundProvider(
            systemInfoProvider: SystemInfoProvider()
        )
    }

    private var eligibilityProvider: IEligibilityProvider {
        EligibilityProvider()
    }

    private var redeemCodeProvider: IRedeemCodeProvider {
        RedeemCodeProvider(systemInfoProvider: systemInfoProvider)
    }

    private lazy var systemInfoProvider: ISystemInfoProvider = SystemInfoProvider()
}
