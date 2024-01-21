//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
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
        print(IAPError.unknown)

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
        XCTAssertTrue(iapProviderMock.invokedPurchaseWithPromotionalOffer)
        XCTAssertEqual(iapProviderMock.invokedPurchaseWithPromotionalOfferParameters?.product.productIdentifier, .productID)
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
        iapProviderMock.stubbedPurchaseWithPromotionalOffer = .success(paymentTransaction)

        // when
        var transaction: IStoreTransaction?
        sut.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { result in
            transaction = result.success
        })
        iapProviderMock.invokedPurchaseParameters?.completion(.success(paymentTransaction))

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchaseWithPromotionalOffer)
        XCTAssertEqual(transaction?.productIdentifier, paymentTransaction.productIdentifier)
    }

    func test_thatFlareDoesNotPurchaseAProduct_whenPurchaseReturnsUnkownError() {
        // given
        let errorMock = IAPError.paymentNotAllowed
        iapProviderMock.stubbedCanMakePayments = true
        iapProviderMock.stubbedPurchaseWithPromotionalOffer = .failure(errorMock)

        // when
        var error: IAPError?
        sut.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { result in
            error = result.error
        })
        iapProviderMock.invokedPurchaseParameters?.completion(.failure(errorMock))

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchaseWithPromotionalOffer)
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
        iapProviderMock.stubbedPurchaseAsyncWithPromotionalOffer = transactionMock

        // when
        let transaction = await value(for: { try await sut.purchase(product: .fake(skProduct: .fake(id: .productID))) })

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchaseAsyncWithPromotionalOffer)
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
        sut.finish(transaction: StoreTransaction(paymentTransaction: transaction), completion: nil)

        // then
        XCTAssertTrue(iapProviderMock.invokedFinishTransaction)
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
        let _ = try await sut.checkEligibility(productIDs: [.productID])

        // then
        XCTAssertEqual(iapProviderMock.invokedCheckEligibilityCount, 1)
        XCTAssertEqual(iapProviderMock.invokedCheckEligibilityParameters?.productIDs, [.productID])
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
