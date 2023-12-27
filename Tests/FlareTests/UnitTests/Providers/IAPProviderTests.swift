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

    private var iapProvider: IIAPProvider!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        paymentQueueMock = PaymentQueueMock()
        productProviderMock = ProductProviderMock()
        purchaseProvider = PurchaseProviderMock()
        receiptRefreshProviderMock = ReceiptRefreshProviderMock()
        refundProviderMock = RefundProviderMock()
        iapProvider = IAPProvider(
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
        iapProvider = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_thatIAPProviderCanMakePayments() {
        // given
        paymentQueueMock.stubbedCanMakePayments = true

        // then
        XCTAssertTrue(iapProvider.canMakePayments)
    }

    func test_thatIAPProviderFetchesProducts() throws {
        try AvailabilityChecker.iOS15APINotAvailableOrSkipTest()

        // when
        iapProvider.fetch(productIDs: .productIDs, completion: { _ in })

        // then
        let parameters = try XCTUnwrap(productProviderMock.invokedFetchParameters)
        XCTAssertEqual(parameters.productIDs, .productIDs)
        XCTAssertTrue(!parameters.requestID.isEmpty)
    }

    func test_thatIAPProviderPurchasesProduct() throws {
        // when
        iapProvider.purchase(productID: .productID, completion: { _ in })

        // then
        XCTAssertTrue(productProviderMock.invokedFetch)
    }

    func test_thatIAPProviderRefreshesReceipt() {
        // when
        iapProvider.refreshReceipt(completion: { _ in })

        // then
        XCTAssertTrue(receiptRefreshProviderMock.invokedRefresh)
    }

    func test_thatIAPProviderFinishesTransaction() {
        // given
        let transaction = PurchaseManagerTestHelper.makePaymentTransaction(state: .purchased)

        // when
        iapProvider.finish(transaction: PaymentTransaction(transaction))

        // then
        XCTAssertTrue(purchaseProvider.invokedFinish)
    }

    func test_thatIAPProviderAddsTransactionObserver() {
        // when
        iapProvider.addTransactionObserver(fallbackHandler: { _ in })

        // then
        XCTAssertTrue(purchaseProvider.invokedAddTransactionObserver)
    }

    func test_thatIAPProviderRemovesTransactionObserver() {
        // when
        iapProvider.removeTransactionObserver()

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
        let products = try await iapProvider.fetch(productIDs: .productIDs)

        // then
        XCTAssertEqual(productsMock.count, products.count)
    }

    #if os(iOS)
        @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
        func test_thatIAPProviderFetchesSK2Products_whenProductsAreAvailable() async throws {
            guard #available(iOS 17.0, *) else {
                throw XCTSkip("This test is currently working only on iOS 17")
            }

            let productsMock = try await ProductProviderHelper.all.map(SK2StoreProduct.init)
            productProviderMock.stubbedAsyncFetchResult = .success(productsMock)

            // when
            let products = try await iapProvider.fetch(productIDs: .productIDs)

            // then
            XCTAssertFalse(products.isEmpty)
            XCTAssertEqual(productsMock.count, products.count)
        }
    #endif

    func test_thatIAPProviderThrowsNoProductsError_whenProductsProductProviderReturnsError() async throws {
        try AvailabilityChecker.iOS15APINotAvailableOrSkipTest()

        // given
        productProviderMock.stubbedFetchResult = .failure(IAPError.unknown)

        // when
        var errorResult: Error?
        do {
            _ = try await iapProvider.fetch(productIDs: .productIDs)
        } catch {
            errorResult = error
        }

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.unknown as NSError)
    }

    func test_thatIAPProviderThrowsStoreProductNotAvailableError_whenProductProviderDoesNotHaveProducts() {
        // given
        productProviderMock.stubbedFetchResult = .success([])

        // when
        var error: Error?
        iapProvider.purchase(productID: .productID) { result in
            if case let .failure(result) = result {
                error = result
            }
        }

        // then
        XCTAssertEqual(error as? NSError, IAPError.storeProductNotAvailable as NSError)
    }

    func test_thatIAPProviderReturnsError_whenAddingPaymentFailed() {
        // given
        productProviderMock.stubbedFetchResult = .success([SK1StoreProduct(ProductMock())])
        purchaseProvider.stubbedPurchaseCompletionResult = (.failure(.unknown), ())

        // when
        var errorResult: Error?
        iapProvider.purchase(productID: .productID) { result in
            if case let .failure(error) = result {
                errorResult = error
            }
        }

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.unknown as NSError)
    }

    func test_thatIAPProviderReturnsError_whenFetchRequestFailed() {
        // given
        productProviderMock.stubbedFetchResult = .failure(.storeProductNotAvailable)

        // when
        var errorResult: Error?
        iapProvider.purchase(productID: .productID) { result in
            if case let .failure(error) = result {
                errorResult = error
            }
        }

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.storeProductNotAvailable as NSError)
    }

    func test_thatIAPProviderThrowsStoreProductNotAvailableError_whenProductsDoNotExist() async throws {
        // given
        productProviderMock.stubbedFetchResult = .success([])

        // when
        var errorResult: Error?
        do {
            _ = try await iapProvider.purchase(productID: .productID)
        } catch {
            errorResult = error
        }

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.storeProductNotAvailable as NSError)
    }

    func test_thatIAPProviderRefreshesReceipt_when() {
        // given
        receiptRefreshProviderMock.stubbedReceipt = .receipt
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        var receiptResult: String?
        iapProvider.refreshReceipt { result in
            if case let .success(receipt) = result {
                receiptResult = receipt
            }
        }

        // then
        XCTAssertEqual(receiptResult, .receipt)
    }

    func test_thatIAPProviderDoesNotRefreshReceipt_whenRequestFailed() {
        // given
        receiptRefreshProviderMock.stubbedReceipt = nil
        receiptRefreshProviderMock.stubbedRefreshResult = .failure(.receiptNotFound)

        // when
        var errorResult: Error?
        iapProvider.refreshReceipt { result in
            if case let .failure(error) = result {
                errorResult = error
            }
        }

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.receiptNotFound as NSError)
    }

    func test_thatIAPProviderReturnsReceiptNotFoundError_whenReceiptIsNil() {
        // given
        receiptRefreshProviderMock.stubbedReceipt = nil
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        var errorResult: Error?
        iapProvider.refreshReceipt { result in
            if case let .failure(error) = result {
                errorResult = error
            }
        }

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.receiptNotFound as NSError)
    }

    func test_thatIAPProviderRefreshesReceipt_whenReceiptIsNotNil() async throws {
        // given
        receiptRefreshProviderMock.stubbedReceipt = .receipt
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        let receipt = try await iapProvider.refreshReceipt()

        // then
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatIAPProviderDoesNotRefreshReceipt_whenReceiptIsNil() async throws {
        // given
        receiptRefreshProviderMock.stubbedReceipt = nil
        receiptRefreshProviderMock.stubbedRefreshResult = .success(())

        // when
        var errorResult: Error?
        do {
            _ = try await iapProvider.refreshReceipt()
        } catch {
            errorResult = error
        }

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.receiptNotFound as NSError)
    }

//    func test_thatIAPProviderReturnsTransaction() {
//        // given
//        let transactionMock = SKPaymentTransaction()
//        purchaseProvider.stubbedFallbackHandlerResult = (paymentQueueMock, .success(transactionMock))
//
//        // when
//        var transactionResult: PaymentTransaction?
//        iapProvider.addTransactionObserver { result in
//            if case let .success(transaction) = result {
//                transactionResult = transaction
//            }
//        }
//
//        // then
//        XCTAssertEqual(transactionResult?.skTransaction, transactionMock)
//    }

//    func test_thatIAPProviderReturnsError() {
//        // given
//        purchaseProvider.stubbedFallbackHandlerResult = (paymentQueueMock, .failure(.unknown))
//
//        // when
//        var errorResult: Error?
//        iapProvider.addTransactionObserver { result in
//            if case let .failure(error) = result {
//                errorResult = error
//            }
//        }
//
//        // then
//        XCTAssertEqual(errorResult as? NSError, IAPError.unknown as NSError)
//    }

    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        func test_thatIAPProviderRefundsPurchase() async throws {
            // given
            refundProviderMock.stubbedBeginRefundRequest = .success

            // when
            let state = try await iapProvider.beginRefundRequest(productID: .productID)

            // then
            if case .success = state {}
            else { XCTFail("state must be `success`") }
        }

        @available(iOS 15.0, *)
        func test_thatFlareThrowsAnError_whenBeginRefundRequestFailed() async throws {
            // given
            refundProviderMock.stubbedBeginRefundRequest = .failed(error: IAPError.unknown)

            // when
            let state = try await iapProvider.beginRefundRequest(productID: .productID)

            // then
            if case let .failed(error) = state { XCTAssertEqual(error as NSError, IAPError.unknown as NSError) }
            else { XCTFail("state must be `failed`") }
        }
    #endif
}

// MARK: - Constants

private extension String {
    static let receipt = "receipt"
    static let productID = "product_identifier"
}

private extension Set where Element == String {
    static let productIDs: Set<Element> = .init(arrayLiteral: "1", "2", "3")
}
