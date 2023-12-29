//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import XCTest

// MARK: - IAPProviderTests

class IAPProviderTests: XCTestCase {
    // MARK: - Properties

    private var paymentQueueMock: PaymentQueueMock!
    private var productProviderMock: ProductProviderMock!
    private var purchaseProvider: PurchaseProviderMock!
    private var receiptRefreshProviderMock: ReceiptRefreshProviderMock!
    private var refundProviderMock: RefundProviderMock!

    private var sut: IIAPProvider!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        paymentQueueMock = PaymentQueueMock()
        productProviderMock = ProductProviderMock()
        purchaseProvider = PurchaseProviderMock()
        receiptRefreshProviderMock = ReceiptRefreshProviderMock()
        refundProviderMock = RefundProviderMock()
        sut = IAPProvider(
            paymentQueue: paymentQueueMock,
            productProvider: productProviderMock,
            purchaseProvider: purchaseProvider,
            receiptRefreshProvider: receiptRefreshProviderMock,
            refundProvider: refundProviderMock
        )
    }

    override func tearDown() {
        paymentQueueMock = nil
        productProviderMock = nil
        purchaseProvider = nil
        receiptRefreshProviderMock = nil
        refundProviderMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_thatIAPProviderCanMakePayments() {
        // given
        paymentQueueMock.stubbedCanMakePayments = true

        // then
        XCTAssertTrue(sut.canMakePayments)
    }

    func test_thatIAPProviderFetchesProducts() throws {
        try AvailabilityChecker.iOS15APINotAvailableOrSkipTest()

        // when
        sut.fetch(productIDs: .productIDs, completion: { _ in })

        // then
        let parameters = try XCTUnwrap(productProviderMock.invokedFetchParameters)
        XCTAssertEqual(parameters.productIDs, .productIDs)
        XCTAssertTrue(!parameters.requestID.isEmpty)
    }

    func test_thatIAPProviderPurchasesProduct() throws {
        // when
        sut.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { _ in })

        // then
        XCTAssertTrue(purchaseProvider.invokedPurchase)
    }

    func test_thatIAPProviderRefreshesReceipt() {
        // when
        sut.refreshReceipt(completion: { _ in })

        // then
        XCTAssertTrue(receiptRefreshProviderMock.invokedRefresh)
    }

    func test_thatIAPProviderFinishesTransaction() {
        // given
        let transaction = PurchaseManagerTestHelper.makePaymentTransaction(state: .purchased)

        // when
        sut.finish(transaction: PaymentTransaction(transaction))

        // then
        XCTAssertTrue(purchaseProvider.invokedFinish)
    }

    func test_thatIAPProviderAddsTransactionObserver() {
        // when
        sut.addTransactionObserver(fallbackHandler: { _ in })

        // then
        XCTAssertTrue(purchaseProvider.invokedAddTransactionObserver)
    }

    func test_thatIAPProviderRemovesTransactionObserver() {
        // when
        sut.removeTransactionObserver()

        // then
        XCTAssertTrue(purchaseProvider.invokedRemoveTransactionObserver)
    }

    // FIXME: Update test
    func test_thatIAPProviderFetchesSK1Products_whenProductsAvailable() async throws {
        try AvailabilityChecker.iOS15APINotAvailableOrSkipTest()

        // given
        let productsMock = [0 ... 2].map { _ in SK1StoreProduct(ProductMock()) }
        productProviderMock.stubbedFetchResult = .success(productsMock)

        // when
        let products = try await sut.fetch(productIDs: .productIDs)

        // then
        XCTAssertEqual(productsMock.count, products.count)
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func test_thatIAPProviderFetchesSK2Products_whenProductsAreAvailable() async throws {
        let productsMock = try await ProductProviderHelper.purchases.map(SK2StoreProduct.init)
        productProviderMock.stubbedAsyncFetchResult = .success(productsMock)

        // when
        let products = try await sut.fetch(productIDs: .productIDs)

        // then
        XCTAssertFalse(products.isEmpty)
        XCTAssertEqual(productsMock.count, products.count)
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func test_thatIAPProviderThrowsAnIAPError_whenFetchingProductsFailed() async {
        productProviderMock.stubbedAsyncFetchResult = .failure(IAPError.unknown)

        // when
        let error: IAPError? = await error(for: { try await sut.fetch(productIDs: .productIDs) })

        // then
        XCTAssertEqual(error, .unknown)
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func test_thatIAPProviderThrowsAPlainError_whenFetchingProductsFailed() async {
        productProviderMock.stubbedAsyncFetchResult = .failure(URLError(.unknown))

        // when
        let error: IAPError? = await error(for: { try await sut.fetch(productIDs: .productIDs) })

        // then
        XCTAssertEqual(error, .with(error: URLError(.unknown)))
    }

    func test_thatIAPProviderThrowsNoProductsError_whenProductsProductProviderReturnsError() async throws {
        try AvailabilityChecker.iOS15APINotAvailableOrSkipTest()

        // given
        productProviderMock.stubbedFetchResult = .failure(IAPError.unknown)

        // when
        let errorResult: Error? = await error(for: { try await sut.fetch(productIDs: .productIDs) })

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.unknown as NSError)
    }

    func test_thatIAPProviderReturnsError_whenAddingPaymentFailed() {
        // given
        productProviderMock.stubbedFetchResult = .success([SK1StoreProduct(ProductMock())])
        purchaseProvider.stubbedPurchaseCompletionResult = (.failure(.unknown), ())

        // when
        var error: Error?
        sut.purchase(product: .fake(skProduct: .fake(id: .productID))) { error = $0.error }

        // then
        XCTAssertEqual(error as? NSError, IAPError.unknown as NSError)
    }

    func test_thatIAPProviderReturnsError_whenFetchRequestFailed() {
        // given
        purchaseProvider.stubbedPurchaseCompletionResult = (.failure(IAPError.unknown), ())

        // when
        var error: Error?
        sut.purchase(product: .fake(skProduct: .fake(id: .productID))) { error = $0.error }

        // then
        XCTAssertEqual(error as? NSError, IAPError.unknown as NSError)
    }

    func test_thatIAPProviderRefreshesReceipt_whenReceiptExist() {
        // given
        receiptRefreshProviderMock.stubbedReceipt = .receipt
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        var receipt: String?
        sut.refreshReceipt { receipt = $0.success }

        // then
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatIAPProviderDoesNotRefreshReceipt_whenRequestFailed() {
        // given
        receiptRefreshProviderMock.stubbedReceipt = nil
        receiptRefreshProviderMock.stubbedRefreshResult = .failure(.receiptNotFound)

        // when
        var error: Error?
        sut.refreshReceipt { error = $0.error }

        // then
        XCTAssertEqual(error as? NSError, IAPError.receiptNotFound as NSError)
    }

    func test_thatIAPProviderReturnsReceiptNotFoundError_whenReceiptIsNil() {
        // given
        receiptRefreshProviderMock.stubbedReceipt = nil
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        var error: Error?
        sut.refreshReceipt { error = $0.error }

        // then
        XCTAssertEqual(error as? NSError, IAPError.receiptNotFound as NSError)
    }

    func test_thatIAPProviderRefreshesReceipt_whenReceiptIsNotNil() async throws {
        // given
        receiptRefreshProviderMock.stubbedReceipt = .receipt
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        let receipt = try await sut.refreshReceipt()

        // then
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatIAPProviderDoesNotRefreshReceipt_whenReceiptIsNil() async throws {
        // given
        receiptRefreshProviderMock.stubbedReceipt = nil
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        let errorResult: Error? = await error(for: { try await sut.refreshReceipt() })

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.receiptNotFound as NSError)
    }

    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        func test_thatIAPProviderRefundsPurchase() async throws {
            // given
            refundProviderMock.stubbedBeginRefundRequest = .success

            // when
            let state = try await sut.beginRefundRequest(productID: .productID)

            // then
            if case .success = state {}
            else { XCTFail("state must be `success`") }
        }

        @available(iOS 15.0, *)
        func test_thatFlareThrowsAnError_whenBeginRefundRequestFailed() async throws {
            // given
            refundProviderMock.stubbedBeginRefundRequest = .failed(error: IAPError.unknown)

            // when
            let state = try await sut.beginRefundRequest(productID: .productID)

            // then
            if case let .failed(error) = state { XCTAssertEqual(error as NSError, IAPError.unknown as NSError) }
            else { XCTFail("state must be `failed`") }
        }
    #endif

    func test_thatIAPProviderPurchasesAProduct() async throws {
        // given
        let transactionMock = StoreTransactionMock()
        transactionMock.stubbedTransactionIdentifier = .transactionID

        let storeTransaction = StoreTransaction(storeTransaction: transactionMock)
        purchaseProvider.stubbedPurchaseCompletionResult = (.success(storeTransaction), ())

        let product = try await ProductProviderHelper.purchases[0]

        // when
        let transaction = try await sut.purchase(product: StoreProduct(product: product))

        // then
        XCTAssertEqual(transaction.transactionIdentifier, .transactionID)
    }

    func test_thatIAPProviderPurchasesAProductWithOptions() async throws {
        // given
        let transactionMock = StoreTransactionMock()
        transactionMock.stubbedTransactionIdentifier = .transactionID

        let storeTransaction = StoreTransaction(storeTransaction: transactionMock)
        purchaseProvider.stubbedinvokedPurchaseWithOptionsCompletionResult = (.success(storeTransaction), ())

        let product = try await ProductProviderHelper.purchases[0]

        // when
        let transaction = try await sut.purchase(product: StoreProduct(product: product), options: [])

        // then
        XCTAssertEqual(transaction.transactionIdentifier, .transactionID)
    }
}

// MARK: - Constants

private extension String {
    static let receipt = "receipt"
    static let productID = "product_identifier"
    static let transactionID = "transaction_identifier"
}

private extension Set where Element == String {
    static let productIDs: Set<Element> = .init(arrayLiteral: "1", "2", "3")
}
