//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import FlareMock
import StoreKit
import XCTest

// MARK: - FlareTests

class FlareTests: XCTestCase {
    // MARK: - Properties

    private var dependenciesMock: FlareDependenciesMock!
    private var iapProviderMock: IAPProviderMock!
    private var configurationProviderMock: ConfigurationProviderMock!

    private var sut: Flare!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        iapProviderMock = IAPProviderMock()
        dependenciesMock = FlareDependenciesMock()
        configurationProviderMock = ConfigurationProviderMock()
        dependenciesMock.stubbedIapProvider = iapProviderMock
        dependenciesMock.stubbedConfigurationProvider = configurationProviderMock
        sut = Flare(dependencies: dependenciesMock)
    }

    override func tearDown() {
        configurationProviderMock = nil
        dependenciesMock = nil
        iapProviderMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_thatFlareFetchesProductsWithGivenProductIDs() {
        // when
        sut.fetch(productIDs: Set.ids, completion: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedFetch)
    }

    func test_thatFlareFetchesProductsWithGivenProductIDs() async throws {
        // given
        let productMocks = [
            StoreProduct(ProductMock()),
            StoreProduct(ProductMock()),
            StoreProduct(ProductMock()),
        ]
        iapProviderMock.fetchAsyncResult = productMocks

        // when
        let products = try await sut.fetch(productIDs: Set.ids)

        // then
        XCTAssertEqual(products, productMocks)
    }

    func test_thatFlarePurchasesAProduct_whenUserCanMakePayments() {
        // given
        iapProviderMock.stubbedCanMakePayments = true

        // when
        sut.purchase(product: .fake(productIdentifier: .productID), completion: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchaseWithPromotionalOffer)
        XCTAssertEqual(iapProviderMock.invokedPurchaseWithPromotionalOfferParameters?.product.productIdentifier, .productID)
    }

    func test_thatFlareThrowsAnError_whenUserCannotMakePayments() {
        // given
        iapProviderMock.stubbedCanMakePayments = false

        // when
        sut.purchase(product: .fake(productIdentifier: .productID), completion: { _ in })

        // then
        XCTAssertFalse(iapProviderMock.invokedPurchase)
    }

    func test_thatFlarePurchasesAProduct_whenRequestCompleted() async throws {
        // given
        let paymentTransaction = StoreTransaction(storeTransaction: StoreTransactionStub())
        iapProviderMock.stubbedCanMakePayments = true
        iapProviderMock.stubbedPurchaseWithPromotionalOffer = .success(paymentTransaction)

        // when
        let transaction: IStoreTransaction? = try await withCheckedThrowingContinuation { continuation in
            sut.purchase(product: .fake(productIdentifier: .productID), completion: { result in
                continuation.resume(returning: result.success)
            })
        }

        iapProviderMock.invokedPurchaseParameters?.completion(.success(paymentTransaction))

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchaseWithPromotionalOffer)
        XCTAssertEqual(transaction?.productIdentifier, paymentTransaction.productIdentifier)
    }

    func test_thatFlareDoesNotPurchaseAProduct_whenPurchaseReturnsUnkownError() async throws {
        // given
        let errorMock = IAPError.paymentNotAllowed
        iapProviderMock.stubbedCanMakePayments = true
        iapProviderMock.stubbedPurchaseWithPromotionalOffer = .failure(errorMock)

        // when
        let result: Result<StoreTransaction, IAPError> = try await withCheckedThrowingContinuation { continuation in
            sut.purchase(product: .fake(productIdentifier: .productID), completion: { result in
                continuation.resume(returning: result)
            })
        }

        iapProviderMock.invokedPurchaseParameters?.completion(.failure(errorMock))

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchaseWithPromotionalOffer)
        XCTAssertEqual(result.error, errorMock)
    }

    func test_thatFlareDoesNotPurchaseAProduct_whenUserCannotMakePayments() async {
        // given
        iapProviderMock.stubbedCanMakePayments = false
        iapProviderMock.stubbedAsyncPurchase = StoreTransaction(storeTransaction: StoreTransactionStub())

        // when
        let iapError: IAPError? = await error(for: { try await sut.purchase(product: .fake(productIdentifier: .productID)) })

        // then
        XCTAssertFalse(iapProviderMock.invokedAsyncPurchase)
        XCTAssertEqual(iapError, .paymentNotAllowed)
    }

    func test_thatFlareDoesNotPurchaseAProduct_whenUnknownErrorOccurred() async {
        // given
        let transactionMock = StoreTransaction(storeTransaction: StoreTransactionStub())

        iapProviderMock.stubbedCanMakePayments = true
        iapProviderMock.stubbedPurchaseAsyncWithPromotionalOffer = transactionMock

        // when
        let transaction = await value(for: { try await sut.purchase(product: .fake(productIdentifier: .productID)) })

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchaseAsyncWithPromotionalOffer)
        XCTAssertEqual(transaction?.productIdentifier, transactionMock.productIdentifier)
    }

    func test_thatFlareFetchesReceipt_whenRequestCompleted() async throws {
        // when
        let result: Result<String, IAPError> = try await withCheckedThrowingContinuation { continuation in
            sut.receipt { result in
                continuation.resume(returning: result)
            }

            iapProviderMock.invokedRefreshReceiptParameters?.completion(.success(.receipt))
        }

        // then
        XCTAssertTrue(iapProviderMock.invokedRefreshReceipt)
        XCTAssertEqual(result.success, .receipt)
    }

    func test_thatFlareDoesNotFetchReceipt_whenRequestFailed() async throws {
        // when
        let result = try await withCheckedThrowingContinuation { continuation in
            sut.receipt { result in
                continuation.resume(returning: result)
            }

            iapProviderMock.invokedRefreshReceiptParameters?.completion(.failure(.paymentNotAllowed))
        }

        // then
        XCTAssertTrue(iapProviderMock.invokedRefreshReceipt)
        XCTAssertEqual(result.error, .paymentNotAllowed)
    }

    func test_thatFlareRemovesTransactionObserver() {
        // when
        sut.removeTransactionObserver()

        // then
        XCTAssertTrue(iapProviderMock.invokedRemoveTransactionObserver)
    }

    func test_thatFlareFetchesReceiptAsync_whenRequestCompleted() async throws {
        // given
        iapProviderMock.stubbedRefreshReceiptAsyncResult = .success(.receipt)

        // when
        let receipt = try await sut.receipt()

        // then
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatFlareDoesNotFetchReceiptAsync_whenRequestFailed() async {
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
        sut.finish(transaction: StoreTransaction(paymentTransaction: transaction), completion: nil)

        // then
        XCTAssertTrue(iapProviderMock.invokedFinishTransaction)
    }

    func test_thatFlareFinishesAsyncTransaction() async {
        // given
        let transaction = PaymentTransaction(PaymentTransactionMock())

        // when
        await sut.finish(transaction: StoreTransaction(paymentTransaction: transaction))

        // then
        XCTAssertTrue(iapProviderMock.invokedFinishAsyncTransaction)
    }

    func test_thatFlareAddsTransactionObserver() {
        // when
        sut.addTransactionObserver(fallbackHandler: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedAddTransactionObserver)
    }

    @available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
    func test_thatFlareChecksEligibility() async throws {
        // given
        iapProviderMock.stubbedCheckEligibility = [.productID: .eligible]

        // when
        _ = try await sut.checkEligibility(productIDs: [.productID])

        // then
        XCTAssertEqual(iapProviderMock.invokedCheckEligibilityCount, 1)
        XCTAssertEqual(iapProviderMock.invokedCheckEligibilityParameters?.productIDs, [.productID])
    }
}

// MARK: - Constants

private extension Set<String> {
    static let ids = Set(arrayLiteral: "1", "2", "3")
}

private extension String {
    static let productID = "product_ID"
    static let receipt = "receipt"
}
