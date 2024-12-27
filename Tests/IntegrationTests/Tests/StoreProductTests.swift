//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import XCTest

// MARK: - StoreProductTests

@available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *)
final class StoreProductTests: StoreSessionTestCase {
    // MARK: Private

    private var provider: IProductProvider!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        provider = ProductProvider()
    }

    override func tearDown() {
        provider = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_sk1ProductWrapsCorrectly() async throws {
        // given
        let expectation = XCTestExpectation(description: "Purchase a product")

        // when
        let products: [StoreProduct] = try await withCheckedThrowingContinuation { continuation in
            provider.fetch(productIDs: [String.productID], requestID: UUID().uuidString) { result in
                switch result {
                case let .success(skProducts):
                    let products = skProducts.map { StoreProduct($0) }
                    continuation.resume(returning: products)
                case .failure:
                    continuation.resume(returning: [])
                }
                expectation.fulfill()
            }
        }

        #if swift(>=5.9)
            await fulfillment(of: [expectation])
        #else
            wait(for: [expectation], timeout: .seconds)
        #endif

        // then
        let storeProduct = try XCTUnwrap(products.first)

        // then
        XCTAssertEqual(storeProduct.productIdentifier, .productID)
        XCTAssertEqual(storeProduct.productCategory, .subscription)
        XCTAssertEqual(storeProduct.productType, nil)
        XCTAssertEqual(storeProduct.localizedDescription, "Subscription")
        XCTAssertEqual(storeProduct.localizedTitle, "Subscription")
        XCTAssertEqual(storeProduct.currencyCode, "USD")
        XCTAssertEqual(storeProduct.price.description, "0.99")
        XCTAssertEqual(storeProduct.localizedPriceString, "$0.99")
        XCTAssertEqual(storeProduct.subscriptionGroupIdentifier, "C3C61FEC")

        XCTAssertEqual(storeProduct.subscriptionPeriod?.unit, .month)
        XCTAssertEqual(storeProduct.subscriptionPeriod?.value, 1)

        let intro = try XCTUnwrap(storeProduct.introductoryDiscount)

        XCTAssertEqual(intro.price, 0.99)
        XCTAssertEqual(intro.paymentMode, .payUpFront)
        XCTAssertEqual(intro.type, .introductory)
        XCTAssertEqual(intro.offerIdentifier, nil)
        XCTAssertEqual(intro.subscriptionPeriod, SubscriptionPeriod(value: 1, unit: .month))

        let offers = try XCTUnwrap(storeProduct.discounts)
        XCTAssertEqual(offers.count, 3)

        XCTAssertEqual(offers[0].price, 0.99)
        XCTAssertEqual(offers[0].paymentMode, .payAsYouGo)
        XCTAssertEqual(offers[0].type, .promotional)
        XCTAssertEqual(offers[0].offerIdentifier, "com.flare.monthly_0.99.1_week_intro")
        XCTAssertEqual(offers[0].subscriptionPeriod, SubscriptionPeriod(value: 1, unit: .month))
        XCTAssertEqual(offers[0].numberOfPeriods, 1)
        XCTAssertEqual(offers[0].currencyCode, "USD")

        XCTAssertEqual(offers[1].price, 1.99)
        XCTAssertEqual(offers[1].paymentMode, .payUpFront)
        XCTAssertEqual(offers[1].type, .promotional)
        XCTAssertEqual(offers[1].offerIdentifier, "com.flare.monthly_0.99.1_week_intro")
        XCTAssertEqual(offers[1].subscriptionPeriod, SubscriptionPeriod(value: 1, unit: .month))
        XCTAssertEqual(offers[1].numberOfPeriods, 1)
        XCTAssertEqual(offers[1].currencyCode, "USD")

        XCTAssertEqual(offers[2].price, 0)
        XCTAssertEqual(offers[2].paymentMode, .freeTrial)
        XCTAssertEqual(offers[2].type, .promotional)
        XCTAssertEqual(offers[2].offerIdentifier, "com.flare.monthly_0.99.1_week_intro")
        XCTAssertEqual(offers[2].subscriptionPeriod, SubscriptionPeriod(value: 1, unit: .week))
        XCTAssertEqual(offers[2].numberOfPeriods, 1)
        XCTAssertEqual(offers[2].currencyCode, "USD")
    }

    @available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
    func test_sk2ProductWrapsCorrectly() async throws {
        // given
        let products = try await StoreKit.Product.products(for: [String.productID])
        let product = try XCTUnwrap(products.first)
        let storeProduct = StoreProduct(product: product)

        // then
        XCTAssertEqual(storeProduct.productIdentifier, .productID)
        XCTAssertEqual(storeProduct.productCategory, .subscription)
        XCTAssertEqual(storeProduct.productType, .autoRenewableSubscription)
        XCTAssertEqual(storeProduct.localizedDescription, "Subscription")
        XCTAssertEqual(storeProduct.localizedTitle, "Subscription")
        XCTAssertEqual(storeProduct.currencyCode, "USD")
        XCTAssertEqual(storeProduct.price.description, "0.99")
        XCTAssertEqual(storeProduct.localizedPriceString, "$0.99")
        XCTAssertEqual(storeProduct.subscriptionGroupIdentifier, "C3C61FEC")

        XCTAssertEqual(storeProduct.subscriptionPeriod?.unit, .month)
        XCTAssertEqual(storeProduct.subscriptionPeriod?.value, 1)

        let intro = try XCTUnwrap(storeProduct.introductoryDiscount)

        XCTAssertEqual(intro.price, 0.99)
        XCTAssertEqual(intro.paymentMode, .payUpFront)
        XCTAssertEqual(intro.type, .introductory)
        XCTAssertEqual(intro.offerIdentifier, nil)
        XCTAssertEqual(intro.subscriptionPeriod, SubscriptionPeriod(value: 1, unit: .month))

        let offers = try XCTUnwrap(storeProduct.discounts)
        XCTAssertEqual(offers.count, 3)

        XCTAssertEqual(offers[0].price, 0.99)
        XCTAssertEqual(offers[0].paymentMode, .payAsYouGo)
        XCTAssertEqual(offers[0].type, .promotional)
        XCTAssertEqual(offers[0].offerIdentifier, "com.flare.monthly_0.99.1_week_intro")
        XCTAssertEqual(offers[0].subscriptionPeriod, SubscriptionPeriod(value: 1, unit: .month))
        XCTAssertEqual(offers[0].numberOfPeriods, 1)
        XCTAssertEqual(offers[0].currencyCode, "USD")

        XCTAssertEqual(offers[1].price, 1.99)
        XCTAssertEqual(offers[1].paymentMode, .payUpFront)
        XCTAssertEqual(offers[1].type, .promotional)
        XCTAssertEqual(offers[1].offerIdentifier, "com.flare.monthly_0.99.1_week_intro")
        XCTAssertEqual(offers[1].subscriptionPeriod, SubscriptionPeriod(value: 1, unit: .month))
        XCTAssertEqual(offers[1].numberOfPeriods, 1)
        XCTAssertEqual(offers[1].currencyCode, "USD")

        XCTAssertEqual(offers[2].price, 0)
        XCTAssertEqual(offers[2].paymentMode, .freeTrial)
        XCTAssertEqual(offers[2].type, .promotional)
        XCTAssertEqual(offers[2].offerIdentifier, "com.flare.monthly_0.99.1_week_intro")
        XCTAssertEqual(offers[2].subscriptionPeriod, SubscriptionPeriod(value: 1, unit: .week))
        XCTAssertEqual(offers[2].numberOfPeriods, 1)
        XCTAssertEqual(offers[2].currencyCode, "USD")
    }
}

// MARK: - Constants

private extension String {
    static let productID = "com.flare.monthly_0.99.1_week_intro"
}

private extension TimeInterval {
    static let seconds: CGFloat = 60.0
}
