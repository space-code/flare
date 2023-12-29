//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import XCTest

// MARK: - FlareStoreKit2Tests

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
final class FlareStoreKit2Tests: StoreSessionTestCase {
    // MARK: - Properties

    private var iapProviderMock: IAPProviderMock!

    private var sut: Flare!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        iapProviderMock = IAPProviderMock()
        sut = Flare(iapProvider: iapProviderMock)
    }

    override func tearDown() {
        iapProviderMock = nil
        sut = nil
        super.tearDown()
    }

    #if os(iOS) || VISION_OS
        func test_thatFlareRefundsPurchase() async throws {
            // given
            iapProviderMock.stubbedBeginRefundRequest = .success

            // when
            let state = try await sut.beginRefundRequest(productID: .productID)

            // then
            if case .success = state {}
            else { XCTFail("state must be `success`") }
        }

        func test_thatFlareRefundRequestThrowsAnError_whenBeginRefundRequestFailed() async throws {
            // given
            iapProviderMock.stubbedBeginRefundRequest = .failed(error: IAPError.unknown)

            // when
            let state = try await sut.beginRefundRequest(productID: .productID)

            // then
            if case let .failed(error) = state { XCTAssertEqual(error as NSError, IAPError.unknown as NSError) }
            else { XCTFail("state must be `failed`") }
        }
    #endif

    func test_thatFlarePurchasesAProductWithOptions_whenPurchaseCompleted() async throws {
        let transaction = StoreTransactionStub()
        try await test_purchaseWithOptionsAndCompletion(
            transaction: transaction,
            canMakePayments: true,
            expectedResult: .success(StoreTransaction(storeTransaction: transaction))
        )
    }

    func test_thatFlarePurchaseThrowsAnError_whenPaymentNotAllowed() async throws {
        try await test_purchaseWithOptionsAndCompletion(
            canMakePayments: false,
            expectedResult: .failure(IAPError.paymentNotAllowed)
        )
    }

    func test_thatFlarePurchasesAsyncAProductWithOptionsAndCompletionHandler_whenPurchaseCompleted() async throws {
        let transaction = StoreTransactionStub()
        try await test_purchaseWithOptions(
            canMakePayments: true,
            expectedResult: .success(StoreTransaction(storeTransaction: transaction))
        )
    }

    func test_thatFlarePurchaseAsyncThrowsAnError_whenPaymentNotAllowed() async throws {
        try await test_purchaseWithOptions(
            canMakePayments: false,
            expectedResult: .failure(IAPError.paymentNotAllowed)
        )
    }

    // MARK: Private

    private func test_purchaseWithOptionsAndCompletion(
        transaction: StoreTransactionStub? = nil,
        canMakePayments: Bool,
        expectedResult: Result<StoreTransaction, IAPError>
    ) async throws {
        // given
        let product = try await ProductProviderHelper.purchases.randomElement()
        let storeTransactionStub = transaction ?? StoreTransactionStub()
        storeTransactionStub.stubbedProductIdentifier = product?.id

        iapProviderMock.stubbedCanMakePayments = canMakePayments
        iapProviderMock.stubbedAsyncPurchaseWithOptions = StoreTransaction(
            storeTransaction: storeTransactionStub
        )

        // when
        let result: Result<StoreTransaction, IAPError> = await result(for: {
            try await sut.purchase(
                product: StoreProduct(product: product!),
                options: [.simulatesAskToBuyInSandbox(false)]
            )
        })

        // then
        XCTAssertEqual(result, expectedResult)
    }

    private func test_purchaseWithOptions(
        transaction: StoreTransactionStub? = nil,
        canMakePayments: Bool,
        expectedResult: Result<StoreTransaction, IAPError>
    ) async throws {
        // given
        let expectation = XCTestExpectation(description: "Purchase a product")

        let product = try await ProductProviderHelper.purchases.randomElement()
        let storeTransactionStub = transaction ?? StoreTransactionStub()
        storeTransactionStub.stubbedProductIdentifier = product?.id

        iapProviderMock.stubbedCanMakePayments = canMakePayments
        iapProviderMock.stubbedPurchaseWithOptionsResult = .success(StoreTransaction(storeTransaction: storeTransactionStub))

        // when
        sut.purchase(
            product: StoreProduct(product: product!),
            options: [.simulatesAskToBuyInSandbox(false)]
        ) { result in
            XCTAssertEqual(result, expectedResult)
            expectation.fulfill()
        }

        // then
        wait(for: [expectation], timeout: .second)
    }
}

// MARK: - Constants

private extension TimeInterval {
    static let second: CGFloat = 1.0
}

private extension String {
    static let productID = "com.flare.test_purchase_2"
}
