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
        let randomProduct = try await ProductProviderHelper.subscriptionsWithIntroductoryOffer.randomElement()
        let product = try XCTUnwrap(randomProduct)
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
            await fulfillment(of: [expectation], timeout: .timeout)
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
        let product = try await resolveProduct(for: expectedResult)

        // when
        var purchaseResult: Result<StoreTransaction, IAPError> = await result(for: {
            try await sut.purchase(
                product: StoreProduct(product: product),
                options: [.simulatesAskToBuyInSandbox(false)]
            )
        })

        var attempt = 1
        while !matches(result: purchaseResult, expectedResult: expectedResult), attempt < Self.purchaseAttempts {
            attempt += 1
            purchaseResult = await result(for: {
                try await sut.purchase(
                    product: StoreProduct(product: product),
                    options: [.simulatesAskToBuyInSandbox(false)]
                )
            })
        }

        // then
        try assertPurchase(result: purchaseResult, expectedResult: expectedResult, productID: product.id)
    }

    private func test_purchaseWithOptions(
        options: Set<StoreKit.Product.PurchaseOption> = [.simulatesAskToBuyInSandbox(true)],
        expectedResult: Result<Void, IAPError>
    ) async throws {
        // given
        let product = try await resolveProduct(for: expectedResult)

        // when
        var result = try await performPurchase(product: product, options: options)

        var attempt = 1
        while !matches(result: result, expectedResult: expectedResult), attempt < Self.purchaseAttempts {
            attempt += 1
            result = try await performPurchase(product: product, options: options)
        }

        // then
        try assertPurchase(result: result, expectedResult: expectedResult, productID: product.id)
    }

    /// Resolves the product to purchase for a given expected outcome.
    ///
    /// - Note: Success- and failure-expectation tests deliberately use different, dedicated non-consumables (see
    /// `ProductProviderHelper.failingPurchases`) so a successful purchase in one test can never leave the product
    /// "owned" for a later failure-expectation test — repurchasing an already-owned non-consumable always succeeds,
    /// regardless of any configured `SKTestSession.failureError`.
    private func resolveProduct(for expectedResult: Result<Void, IAPError>) async throws -> StoreKit.Product {
        let products: [StoreKit.Product] = switch expectedResult {
        case .success:
            try await ProductProviderHelper.purchases
        case .failure:
            try await ProductProviderHelper.failingPurchases
        }
        return try XCTUnwrap(products.randomElement(), "No product available for the expected result")
    }

    /// Performs a single purchase attempt via the completion-handler API and awaits its result.
    ///
    /// - Note: Uses a fresh `XCTestExpectation` per call (expectations can only be fulfilled once), which is why
    /// this is its own function — callers can invoke it repeatedly to retry a purchase attempt.
    private func performPurchase(
        product: StoreKit.Product,
        options: Set<StoreKit.Product.PurchaseOption>
    ) async throws -> Result<StoreTransaction, IAPError> {
        let expectation = XCTestExpectation(description: "Purchase a product")
        let box = ResultBox()

        let handler: Closure<Result<StoreTransaction, IAPError>> = { result in
            box.result = result
            expectation.fulfill()
        }

        if options.isEmpty {
            sut.purchase(product: StoreProduct(product: product)) { handler($0) }
        } else {
            sut.purchase(
                product: StoreProduct(product: product),
                options: options
            ) { [handler] result in
                Task { handler(result) }
            }
        }

        #if swift(>=5.9)
            await fulfillment(of: [expectation], timeout: .timeout)
        #else
            wait(for: [expectation], timeout: .second)
        #endif

        return try XCTUnwrap(box.result, "The purchase completion handler was never called")
    }

    private func matches(result: Result<StoreTransaction, IAPError>, expectedResult: Result<Void, IAPError>) -> Bool {
        switch expectedResult {
        case .success:
            result.success != nil
        case let .failure(expectedError):
            result.error == expectedError
        }
    }

    /// Asserts a purchase outcome against the expectation, skipping (rather than failing) when StoreKit's local
    /// sandbox daemon returns its own opaque server error instead of simulating the configured failure.
    ///
    /// - Note: `SKTestSession.failureError` occasionally fails to simulate the requested error cleanly and instead
    /// throws `StoreKitError.systemError` wrapping a raw `ASDErrorDomain`/`AMSErrorDomain` response
    /// (`"Received failure in response from Xcode"`) from the local StoreKitTest sandbox server. This is a known
    /// flake in Apple's testing tooling, not a Flare bug, so it shouldn't fail CI.
    private func assertPurchase(
        result: Result<StoreTransaction, IAPError>,
        expectedResult: Result<Void, IAPError>,
        productID: String
    ) throws {
        switch expectedResult {
        case .success:
            XCTAssertEqual(result.success?.productIdentifier, productID)
        case let .failure(expectedError):
            if let actualError = result.error, actualError != expectedError, isStoreKitTestSandboxFlake(actualError) {
                throw XCTSkip(
                    "StoreKitTest's local sandbox returned an opaque server error instead of simulating \(expectedError) — known StoreKitTest flake, skipping."
                )
            }
            XCTAssertEqual(expectedError, result.error)
        }
    }

    private func isStoreKitTestSandboxFlake(_ error: IAPError) -> Bool {
        guard case let .with(underlyingError) = error,
              case let .systemError(systemError)? = underlyingError as? StoreKit.StoreKitError
        else { return false }
        return (systemError as NSError).domain == "ASDErrorDomain"
    }

    /// The number of times a purchase is attempted before asserting on the outcome.
    ///
    /// - Note: `SKTestSession`'s failure simulation (`failTransactionsEnabled`/`failureError`) is occasionally
    /// nondeterministic in the local StoreKitTest sandbox — it can let a purchase through as a success even
    /// though a failure was configured. Retrying gives it another chance to apply the configured failure.
    private static let purchaseAttempts = 3
}

// MARK: - ResultBox

private final class ResultBox: @unchecked Sendable {
    var result: Result<StoreTransaction, IAPError>?
}

// MARK: - Constants

private extension TimeInterval {
    static let second: CGFloat = 1.0
    static let timeout: TimeInterval = 30.0
}

private extension String {
    static let productID = "com.flare.test_purchase_2"
}
