//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import XCTest

// MARK: - FlareTests

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
final class FlareTests: StoreSessionTestCase {
    // MARK: - Properties

    private var sut: Flare!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        sut = Flare()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatFlarePurchasesAProductWithCompletion_whenPurchaseCompleted() async throws {
        try await test_purchaseWithOptions(
            options: [],
            expectedResult: .success(())
        )
    }

    func test_thatFlarePurchasesAProductWithCompletion_whenUnkownErrorOccurred() async throws {
        // given
        session?.failTransactionsEnabled = true
        session?.failureError = .unknown

        // when
        try await test_purchaseWithOptions(
            options: [],
            expectedResult: .failure(.unknown)
        )
    }

    func test_thatFlarePurchasesAProductWithOptions_whenPurchaseCompleted() async throws {
        try await test_purchaseWithOptionsAndCompletion(
            expectedResult: .success(())
        )
    }

    func test_thatFlarePurchaseThrowsAnError_whenUnkownErrorOccurred() async throws {
        // given
        session?.failTransactionsEnabled = true
        session?.failureError = .unknown

        // when
        try await test_purchaseWithOptionsAndCompletion(
            expectedResult: .failure(IAPError.unknown)
        )
    }

    func test_thatFlarePurchasesAsyncAProductWithOptionsAndCompletionHandler_whenPurchaseCompleted() async throws {
        try await test_purchaseWithOptions(
            expectedResult: .success(())
        )
    }

    func test_thatFlarePurchaseAsyncThrowsAnError_whenUnkownErrorOccurred() async throws {
        // given
        session?.failTransactionsEnabled = true
        session?.failureError = .unknown

        // when
        try await test_purchaseWithOptions(
            expectedResult: .failure(IAPError.unknown)
        )
    }

    @available(iOS 15.2, tvOS 15.2, macOS 12.1, watchOS 8.3, *)
    func test_thatPurchaseIntorudctoryOffer() async throws {
        // 1. Fetch a product
        let product = try await XCTUnwrap(ProductProviderHelper.subscriptionsWithIntroductoryOffer.randomElement())
        let storeProduct = StoreProduct(product: product)

        // 2. Checking eligibility for a product
        var eligibleResult = try await Flare.shared.checkEligibility(productIDs: [product.id])[product.id]
        XCTAssertEqual(eligibleResult, .eligible)

        // 3. Purchase the product
        let purchaseTransaction = try await sut.purchase(product: storeProduct)

        // 5. Retrieve a transaction
        var transaction = try await findTransaction(for: product.id)

        // 6. Checking transaction
        XCTAssertEqual(transaction.productID, product.id)
        XCTAssertEqual(transaction.offerType, .introductory)

        // 7. Finish the transaction
        let expectation = XCTestExpectation(description: "Finishing the transaction")
        sut.finish(transaction: purchaseTransaction) { expectation.fulfill() }

        #if swift(>=5.9)
            await fulfillment(of: [expectation])
        #else
            wait(for: [expectation], timeout: .second)
        #endif

        // 8. Checking eligibility for the purchased product
        eligibleResult = try await Flare.shared.checkEligibility(productIDs: [product.id])[product.id]
        XCTAssertEqual(eligibleResult, .nonEligible)

        // 9. Expire subscription
        expireSubscription(product: storeProduct)

        // 10. Purchase the same product again
        _ = try await sut.purchase(product: storeProduct)

        // 11. Retrieve a transaction
        transaction = try await latestTransaction(for: product.id)

        // 12. Checking the transaction
        XCTAssertEqual(transaction.productID, product.id)
        XCTAssertEqual(transaction.offerType, nil)
    }

    // MARK: Private

    private func test_purchaseWithOptionsAndCompletion(
        expectedResult: Result<Void, IAPError>
    ) async throws {
        // given
        let product = try await ProductProviderHelper.purchases.randomElement()

        // when
        let result: Result<StoreTransaction, IAPError> = await result(for: {
            try await sut.purchase(
                product: StoreProduct(product: product!),
                options: [.simulatesAskToBuyInSandbox(false)]
            )
        })

        // then
        switch expectedResult {
        case .success:
            XCTAssertEqual(result.success?.productIdentifier, product?.id)
        case let .failure(error):
            XCTAssertEqual(error, result.error)
        }
    }

    private func test_purchaseWithOptions(
        options: Set<StoreKit.Product.PurchaseOption> = [.simulatesAskToBuyInSandbox(true)],
        expectedResult: Result<Void, IAPError>
    ) async throws {
        // given
        let expectation = XCTestExpectation(description: "Purchase a product")

        let product = try await ProductProviderHelper.purchases.randomElement()

        // when
        let handler: Closure<Result<StoreTransaction, IAPError>> = { result in
            switch expectedResult {
            case .success:
                XCTAssertEqual(result.success?.productIdentifier, product?.id)
            case let .failure(error):
                XCTAssertEqual(error, result.error)
            }
            expectation.fulfill()
        }

        if options.isEmpty {
            sut.purchase(product: StoreProduct(product: product!)) { handler($0) }
        } else {
            sut.purchase(
                product: StoreProduct(product: product!),
                options: options
            ) { [handler] result in
                Task { handler(result) }
            }
        }

        // then
        #if swift(>=5.9)
            await fulfillment(of: [expectation])
        #else
            wait(for: [expectation], timeout: .second)
        #endif
    }
}

// MARK: - Constants

private extension TimeInterval {
    static let second: CGFloat = 1.0
}

private extension String {
    static let productID = "com.flare.test_purchase_2"
}
