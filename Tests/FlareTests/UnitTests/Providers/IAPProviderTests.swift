//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import FlareMock
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
            refundProvider: refundProviderMock,
            eligibilityProvider: EligibilityProviderMock(),
            redeemCodeProvider: RedeemCodeProviderMock()
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
        sut.fetch(productIDs: Set.productIDs, completion: { _ in })

        // then
        let parameters = try XCTUnwrap(productProviderMock.invokedFetchParameters)
        XCTAssertEqual(parameters.productIDs as? Set<String>, Set.productIDs)
        XCTAssertTrue(!parameters.requestID.isEmpty)
    }

    func test_thatIAPProviderPurchasesProduct() {
        // when
        sut.purchase(product: .fake(productIdentifier: .productID), completion: { _ in })

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
        sut.finish(transaction: StoreTransaction(paymentTransaction: PaymentTransaction(transaction)), completion: nil)

        // then
        XCTAssertTrue(purchaseProvider.invokedFinish)
    }

    func test_thatIAPProviderFinishesAsyncTransaction() async {
        // given
        let transaction = PurchaseManagerTestHelper.makePaymentTransaction(state: .purchased)

        // when
        await sut.finish(transaction: StoreTransaction(paymentTransaction: PaymentTransaction(transaction)))

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
        let productsMock = [0 ... 2].map { _ in StoreProduct(SK1StoreProduct(SKProductMock())) }
        productProviderMock.stubbedFetchResult = .success(productsMock)

        // when
        let products = try await sut.fetch(productIDs: Set.productIDs)

        // then
        XCTAssertEqual(productsMock.count, products.count)
    }

    func test_thatIAPProviderThrowsNoProductsError_whenProductsProductProviderReturnsError() async throws {
        try AvailabilityChecker.iOS15APINotAvailableOrSkipTest()

        // given
        productProviderMock.stubbedFetchResult = .failure(IAPError.unknown)

        // when
        let errorResult: Error? = await error(for: { try await sut.fetch(productIDs: Set.productIDs) })

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.unknown as NSError)
    }

    func test_thatIAPProviderReturnsError_whenAddingPaymentFailed() async throws {
        // given
        productProviderMock.stubbedFetchResult = .success([StoreProduct(SK1StoreProduct(SKProductMock()))])
        purchaseProvider.stubbedPurchaseCompletionResult = (.failure(.unknown), ())

        // when
        let error: Error? = try await withCheckedThrowingContinuation { continuation in
            sut.purchase(product: .fake(productIdentifier: .productID)) {
                continuation.resume(returning: $0.error)
            }
        }

        // then
        XCTAssertEqual(error as? NSError, IAPError.unknown as NSError)
    }

    func test_thatIAPProviderReturnsError_whenFetchRequestFailed() async throws {
        // given
        purchaseProvider.stubbedPurchaseCompletionResult = (.failure(IAPError.unknown), ())

        // when
        let error: Error? = try await withCheckedThrowingContinuation { continuation in
            sut.purchase(product: .fake(productIdentifier: .productID)) {
                continuation.resume(returning: $0.error)
            }
        }

        // then
        XCTAssertEqual(error as? NSError, IAPError.unknown as NSError)
    }

    func test_thatIAPProviderRefreshesReceipt_whenReceiptExist() async throws {
        // given
        receiptRefreshProviderMock.stubbedReceipt = .receipt
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        let receipt: String? = try await withCheckedThrowingContinuation { continuation in
            sut.refreshReceipt {
                continuation.resume(returning: $0.success)
            }
        }

        // then
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatIAPProviderDoesNotRefreshReceipt_whenRequestFailed() async throws {
        // given
        receiptRefreshProviderMock.stubbedReceipt = nil
        receiptRefreshProviderMock.stubbedRefreshResult = .failure(.receiptNotFound)

        // when
        let error: Error? = try await withCheckedThrowingContinuation { continuation in
            sut.refreshReceipt {
                continuation.resume(returning: $0.error)
            }
        }

        // then
        XCTAssertEqual(error as? NSError, IAPError.receiptNotFound as NSError)
    }

    func test_thatIAPProviderReturnsReceiptNotFoundError_whenReceiptIsNil() async throws {
        // given
        receiptRefreshProviderMock.stubbedReceipt = nil
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        let error: Error? = try await withCheckedThrowingContinuation { continuation in
            sut.refreshReceipt {
                continuation.resume(returning: $0.error)
            }
        }

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

    func test_thatIAPProviderDoesNotRefreshReceipt_whenReceiptIsNil() async {
        // given
        receiptRefreshProviderMock.stubbedReceipt = nil
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        let errorResult: Error? = await error(for: { try await sut.refreshReceipt() })

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.receiptNotFound as NSError)
    }
}

// MARK: - Constants

private extension String {
    static let receipt = "receipt"
    static let productID = "product_identifier"
    static let transactionID = "transaction_identifier"
}

private extension Set<String> {
    static let productIDs: Set<Element> = .init(arrayLiteral: "1", "2", "3")
}
