//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import XCTest

// MARK: - FlareTests

class FlareTests: XCTestCase {
    // MARK: - Properties

    private var iapProviderMock: IAPProviderMock!
    private var flare: Flare!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        iapProviderMock = IAPProviderMock()
        flare = Flare(iapProvider: iapProviderMock)
    }

    override func tearDown() {
        iapProviderMock = nil
        flare = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_thatFlareFetchesProductsWithGivenProductIDs() {
        // when
        flare.fetch(productIDs: .ids, completion: { _ in })

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
        let products = try await flare.fetch(productIDs: .ids)

        // then
        XCTAssertEqual(products, productMocks)
    }

    func test_thatFlarePurchasesAProduct_whenUserCanMakePayments() {
        // given
        iapProviderMock.stubbedCanMakePayments = true

        // when
        flare.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchase)
        XCTAssertEqual(iapProviderMock.invokedPurchaseParameters?.product.productIdentifier, .productID)
    }

    func test_thatFlareDoesNotPurchaseAProduct_whenUserCannotMakePayments() {
        // given
        iapProviderMock.stubbedCanMakePayments = false

        // when
        flare.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { _ in })

        // then
        XCTAssertFalse(iapProviderMock.invokedPurchase)
    }

    func test_thatFlarePurchasesAProduct_whenRequestCompletedSuccessfully() {
        // given
        let paymentTransaction = StoreTransaction(storeTransaction: StoreTransactionStub())
        iapProviderMock.stubbedCanMakePayments = true

        // when
        var transaction: IStoreTransaction?
        flare.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { result in
            if case let .success(result) = result {
                transaction = result
            }
        })
        iapProviderMock.invokedPurchaseParameters?.completion(.success(paymentTransaction))

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchase)
        XCTAssertEqual(transaction?.productIdentifier, paymentTransaction.productIdentifier)
    }

    func test_thatFlareDoesNotPurchaseAProduct_whenUnknownErrorOccurred() {
        // given
        let errorMock = IAPError.paymentNotAllowed
        iapProviderMock.stubbedCanMakePayments = true

        // when
        var error: IAPError?
        flare.purchase(product: .fake(skProduct: .fake(id: .productID)), completion: { result in
            if case let .failure(result) = result {
                error = result
            }
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
        var iapError: IAPError?
        do {
            _ = try await flare.purchase(product: .fake(skProduct: .fake(id: .productID)))
        } catch {
            iapError = error as? IAPError
        }

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
        var transaction: IStoreTransaction?
        var iapError: IAPError?
        do {
            transaction = try await flare.purchase(product: .fake(skProduct: .fake(id: .productID)))
        } catch {
            iapError = error as? IAPError
        }

        // then
        XCTAssertTrue(iapProviderMock.invokedAsyncPurchase)
        XCTAssertNil(iapError)
        XCTAssertEqual(transaction?.productIdentifier, transactionMock.productIdentifier)
    }

    func test_thatFlareFetchesReceipt_whenRequestCompletedSuccessfully() {
        // when
        var receipt: String?
        flare.receipt(completion: { result in
            if case let .success(result) = result {
                receipt = result
            }
        })
        iapProviderMock.invokedRefreshReceiptParameters?.completion(.success(.receipt))

        // then
        XCTAssertTrue(iapProviderMock.invokedRefreshReceipt)
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatFlareDoesNotFetchReceipt_whenRequestFailed() {
        // when
        var error: IAPError?
        flare.receipt(completion: { result in
            if case let .failure(result) = result {
                error = result
            }
        })
        iapProviderMock.invokedRefreshReceiptParameters?.completion(.failure(.paymentNotAllowed))

        // then
        XCTAssertTrue(iapProviderMock.invokedRefreshReceipt)
        XCTAssertEqual(error, .paymentNotAllowed)
    }

    func test_thatFlareRemovesTransactionObserver() {
        // when
        flare.removeTransactionObserver()

        // then
        XCTAssertTrue(iapProviderMock.invokedRemoveTransactionObserver)
    }

    func test_thatFlareFetchesReceipt_whenRequestCompletedSuccessfully() async throws {
        // given
        iapProviderMock.stubbedRefreshReceiptAsyncResult = .success(.receipt)

        // when
        let receipt = try await flare.receipt()

        // then
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatFlareDoesNotFetchReceipt_whenRequestFailed() async throws {
        // given
        iapProviderMock.stubbedRefreshReceiptAsyncResult = .failure(.paymentNotAllowed)

        // when
        var iapError: IAPError?
        do {
            _ = try await flare.receipt()
        } catch {
            iapError = error as? IAPError
        }

        // then
        XCTAssertEqual(iapError, .paymentNotAllowed)
    }

    func test_thatFlareFinishesTransaction() {
        // given
        let transaction = PaymentTransaction(PaymentTransactionMock())

        // when
        flare.finish(transaction: transaction)

        // then
        XCTAssertTrue(iapProviderMock.invokedFinishTransaction)
    }

    func test_thatFlareAddsTransactionObserver() {
        // when
        flare.addTransactionObserver(fallbackHandler: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedAddTransactionObserver)
    }

    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        func test_thatFlareRefundsPurchase() async throws {
            // given
            iapProviderMock.stubbedBeginRefundRequest = .success

            // when
            let state = try await flare.beginRefundRequest(productID: .productID)

            // then
            if case .success = state {}
            else { XCTFail("state must be `success`") }
        }

        @available(iOS 15.0, *)
        func test_thatFlareThrowsAnError_whenBeginRefundRequestFailed() async throws {
            // given
            iapProviderMock.stubbedBeginRefundRequest = .failed(error: IAPError.unknown)

            // when
            let state = try await flare.beginRefundRequest(productID: .productID)

            // then
            if case let .failed(error) = state { XCTAssertEqual(error as NSError, IAPError.unknown as NSError) }
            else { XCTFail("state must be `failed`") }
        }
    #endif
}

// MARK: - Constants

private extension Set where Element == String {
    static let ids = Set(arrayLiteral: "1", "2", "3")
}

private extension String {
    static let productID = "product_ID"
    static let receipt = "receipt"
}
