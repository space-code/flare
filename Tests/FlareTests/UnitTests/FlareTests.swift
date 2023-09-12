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

    func test_thatPurchaseManagerFetchesProducts() {
        // when
        flare.fetch(ids: .ids, completion: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedFetch)
    }

    func test_thatPurchaseManagerFetchesProductsAsync() async throws {
        // given
        let productMocks = [ProductMock(), ProductMock(), ProductMock()]
        iapProviderMock.fetchAsyncResult = productMocks

        // when
        let products = try await flare.fetch(ids: .ids)

        // then
        XCTAssertEqual(products, productMocks)
    }

    func test_thatPurchaseManagerBuysProduct_whenCanMakePayments() {
        // given
        iapProviderMock.stubbedCanMakePayments = true

        // when
        flare.buy(id: .productID, completion: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchase)
        XCTAssertEqual(iapProviderMock.invokedPurchaseParameters?.productId, .productID)
    }

    func test_thatPurchaseManagerDoesNotBuyProduct_whenCannotMakePayments() {
        // given
        iapProviderMock.stubbedCanMakePayments = false

        // when
        flare.buy(id: .productID, completion: { _ in })

        // then
        XCTAssertFalse(iapProviderMock.invokedPurchase)
    }

    func test_thatPurchaseManagersBuysProduct_whenCanMakePaymentsSuccess() {
        // given
        let paymentTransaction = PaymentTransaction(PaymentTransactionMock())
        iapProviderMock.stubbedCanMakePayments = true

        // when
        var transaction: PaymentTransaction?
        flare.buy(id: .productID, completion: { result in
            if case let .success(result) = result {
                transaction = result
            }
        })
        iapProviderMock.invokedPurchaseParameters?.completion(.success(paymentTransaction))

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchase)
        XCTAssertEqual(transaction, paymentTransaction)
    }

    func test_thatPurchaseManagersBuysProduct_whenCanMakePaymentsFailed() {
        // given
        let errorMock = IAPError.paymentNotAllowed
        iapProviderMock.stubbedCanMakePayments = true

        // when
        var error: IAPError?
        flare.buy(id: .productID, completion: { result in
            if case let .failure(result) = result {
                error = result
            }
        })
        iapProviderMock.invokedPurchaseParameters?.completion(.failure(errorMock))

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchase)
        XCTAssertEqual(error, errorMock)
    }

    func test_thatPurchaseManagerDoesNotBuyProductAsync_whenCannotMakePayments() async {
        // given
        iapProviderMock.stubbedCanMakePayments = false
        iapProviderMock.stubbedAsyncPurchase = PaymentTransaction(PaymentTransactionMock())

        // when
        var iapError: IAPError?
        do {
            _ = try await flare.buy(id: .productID)
        } catch {
            iapError = error as? IAPError
        }

        // then
        XCTAssertFalse(iapProviderMock.invokedAsyncPurchase)
        XCTAssertEqual(iapError, .paymentNotAllowed)
    }

    func test_thatPurchaseManagerBuysProduct_whenCannotMakePayments() async {
        // given
        let transactionMock = PaymentTransaction(PaymentTransactionMock())

        iapProviderMock.stubbedCanMakePayments = true
        iapProviderMock.stubbedAsyncPurchase = transactionMock

        // when
        var transaction: PaymentTransaction?
        var iapError: IAPError?
        do {
            transaction = try await flare.buy(id: .productID)
        } catch {
            iapError = error as? IAPError
        }

        // then
        XCTAssertTrue(iapProviderMock.invokedAsyncPurchase)
        XCTAssertNil(iapError)
        XCTAssertEqual(transaction, transactionMock)
    }

    func test_thatPurchaseManagerFetchReceipt_whenRequestCompleted() {
        // when
        var receipt: String?
        flare.receipt(completion: { result in
            if case let .success(result) = result {
                receipt = result
            }
        })
        iapProviderMock.invokedRefreshReceiptParameters?.0(.success(.receipt))

        // then
        XCTAssertTrue(iapProviderMock.invokedRefreshReceipt)
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatPurchaseManagerFetchReceipt_whenRequestFailed() {
        // when
        var error: IAPError?
        flare.receipt(completion: { result in
            if case let .failure(result) = result {
                error = result
            }
        })
        iapProviderMock.invokedRefreshReceiptParameters?.0(.failure(.paymentNotAllowed))

        // then
        XCTAssertTrue(iapProviderMock.invokedRefreshReceipt)
        XCTAssertEqual(error, .paymentNotAllowed)
    }

    func test_thatPurchaseManagerRemovesTransactionObserver() {
        // when
        flare.removeTransactionObserver()

        // then
        XCTAssertTrue(iapProviderMock.invokedRemoveTransactionObserver)
    }

    func test_thatPurchaseManagerFetchReceiptAsync_whenRequestCompleted() async throws {
        // given
        iapProviderMock.stubbedRefreshReceiptAsyncResult = .success(.receipt)

        // when
        let receipt = try await flare.receipt()

        // then
        XCTAssertEqual(receipt, .receipt)
    }

    func test_thatPurchaseManagerFetchesReceiptAsync_whenRequestFailed() async throws {
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

    func test_thatPurchaseManagerFinishesTransaction() {
        // given
        let transaction = PaymentTransaction(PaymentTransactionMock())

        // when
        flare.finish(transaction: transaction)

        // then
        XCTAssertTrue(iapProviderMock.invokedFinishTransaction)
    }

    func test_thatPurchaseManagerAddsTransactionObserver() {
        // when
        flare.addTransactionObserver(fallbackHandler: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedAddTransactionObserver)
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
