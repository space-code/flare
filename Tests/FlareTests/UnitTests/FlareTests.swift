//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import XCTest

// MARK: - FlareTests

class FlareTests: StoreSessionTestCase {
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

    // MARK: - Tests

    func test_thatFlareFetchesProductsWithGivenProductIDs() {
        // when
        sut.fetch(productIDs: .ids, completion: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedFetch)
    }

    func test_thatFlareFetchesProductsWithGivenProductIDs() async throws {
        // given
        let productMocks = [
            StoreProduct(skProduct: ProductMock()),
            StoreProduct(skProduct: ProductMock()),
            StoreProduct(skProduct: ProductMock()),
        ]
        iapProviderMock.fetchAsyncResult = productMocks

        // when
        let products = try await sut.fetch(productIDs: .ids)

        // then
        XCTAssertEqual(products, productMocks)
    }

    func test_thatFlarePurchasesAProduct_whenUserCanMakePayments() {
        // given
        iapProviderMock.stubbedCanMakePayments = true

        // when
        sut.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchase)
        XCTAssertEqual(iapProviderMock.invokedPurchaseParameters?.product.productIdentifier, .productID)
    }

    func test_thatFlareThrowsAnError_whenUserCannotMakePayments() {
        // given
        iapProviderMock.stubbedCanMakePayments = false

        // when
        sut.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { _ in })

        // then
        XCTAssertFalse(iapProviderMock.invokedPurchase)
    }

    func test_thatFlarePurchasesAProduct_whenRequestCompleted() {
        // given
        let paymentTransaction = StoreTransaction(storeTransaction: StoreTransactionStub())
        iapProviderMock.stubbedCanMakePayments = true

        // when
        var transaction: IStoreTransaction?
        sut.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { result in
            transaction = result.success
        })
        iapProviderMock.invokedPurchaseParameters?.completion(.success(paymentTransaction))

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchase)
        XCTAssertEqual(transaction?.productIdentifier, paymentTransaction.productIdentifier)
    }

    func test_thatFlareDoesNotPurchaseAProduct_whenPurchaseReturnsUnkownError() {
        // given
        let errorMock = IAPError.paymentNotAllowed
        iapProviderMock.stubbedCanMakePayments = true

        // when
        var error: IAPError?
        sut.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { result in
            error = result.error
        })
        iapProviderMock.invokedPurchaseParameters?.completion(.failure(errorMock))

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchase)
        XCTAssertEqual(error, errorMock)
    }

    func test_thatFlareDoesNotPurchaseAProduct_whenUserCannotMakePayments() async {
        // given
        iapProviderMock.stubbedCanMakePayments = false
        iapProviderMock.stubbedAsyncPurchase = StoreTransaction(storeTransaction: StoreTransactionStub())

        // when
        let iapError: IAPError? = await error(for: { try await sut.purchase(product: .fake(skProduct: .fake(id: .productID))) })

        // then
        XCTAssertFalse(iapProviderMock.invokedAsyncPurchase)
        XCTAssertEqual(iapError, .paymentNotAllowed)
    }

    func test_thatFlareDoesNotPurchaseAProduct_whenUnknownErrorOccurred() async {
        // given
        let transactionMock = StoreTransaction(storeTransaction: StoreTransactionStub())

        iapProviderMock.stubbedCanMakePayments = true
        iapProviderMock.stubbedAsyncPurchase = transactionMock

        // when
        let transaction = await value(for: { try await sut.purchase(product: .fake(skProduct: .fake(id: .productID))) })

        // then
        XCTAssertTrue(iapProviderMock.invokedAsyncPurchase)
        XCTAssertEqual(transaction?.productIdentifier, transactionMock.productIdentifier)
    }

    func test_thatFlareFetchesReceipt_whenRequestCompleted() {
        // when
        var receipt: String?
        sut.receipt { receipt = $0.success }

        iapProviderMock.invokedRefreshReceiptParameters?.completion(.success(.receipt))

        // then
        XCTAssertTrue(iapProviderMock.invokedRefreshReceipt)
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatFlareDoesNotFetchReceipt_whenRequestFailed() {
        // when
        var error: IAPError?
        sut.receipt { error = $0.error }

        iapProviderMock.invokedRefreshReceiptParameters?.completion(.failure(.paymentNotAllowed))

        // then
        XCTAssertTrue(iapProviderMock.invokedRefreshReceipt)
        XCTAssertEqual(error, .paymentNotAllowed)
    }

    func test_thatFlareRemovesTransactionObserver() {
        // when
        sut.removeTransactionObserver()

        // then
        XCTAssertTrue(iapProviderMock.invokedRemoveTransactionObserver)
    }

    func test_thatFlareFetchesReceipt_whenRequestCompleted() async throws {
        // given
        iapProviderMock.stubbedRefreshReceiptAsyncResult = .success(.receipt)

        // when
        let receipt = try await sut.receipt()

        // then
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatFlareDoesNotFetchReceipt_whenRequestFailed() async throws {
        // given
        iapProviderMock.stubbedRefreshReceiptAsyncResult = .failure(.paymentNotAllowed)

        // when
        let error: IAPError? = await self.error(for: { try await sut.receipt() })

        // then
        XCTAssertEqual(error, .paymentNotAllowed)
    }

    func test_thatFlareFinishesTransaction() {
        // given
        let transaction = PaymentTransaction(PaymentTransactionMock())

        // when
        sut.finish(transaction: transaction)

        // then
        XCTAssertTrue(iapProviderMock.invokedFinishTransaction)
    }

    func test_thatFlareAddsTransactionObserver() {
        // when
        sut.addTransactionObserver(fallbackHandler: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedAddTransactionObserver)
    }

    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        func test_thatFlareRefundsPurchase() async throws {
            // given
            iapProviderMock.stubbedBeginRefundRequest = .success

            // when
            let state = try await sut.beginRefundRequest(productID: .productID)

            // then
            if case .success = state {}
            else { XCTFail("state must be `success`") }
        }

        @available(iOS 15.0, *)
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

private extension Set where Element == String {
    static let ids = Set(arrayLiteral: "1", "2", "3")
}

private extension String {
    static let productID = "product_ID"
    static let receipt = "receipt"
}

private extension TimeInterval {
    static let second: CGFloat = 1.0
}
