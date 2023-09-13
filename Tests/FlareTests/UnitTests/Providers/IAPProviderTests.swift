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
    private var paymentProviderMock: PaymentProviderMock!
    private var receiptRefreshProviderMock: ReceiptRefreshProviderMock!
    private var iapProvider: IIAPProvider!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        paymentQueueMock = PaymentQueueMock()
        productProviderMock = ProductProviderMock()
        paymentProviderMock = PaymentProviderMock()
        receiptRefreshProviderMock = ReceiptRefreshProviderMock()
        iapProvider = IAPProvider(
            paymentQueue: paymentQueueMock,
            productProvider: productProviderMock,
            paymentProvider: paymentProviderMock,
            receiptRefreshProvider: receiptRefreshProviderMock
        )
    }

    override func tearDown() {
        paymentQueueMock = nil
        productProviderMock = nil
        paymentProviderMock = nil
        receiptRefreshProviderMock = nil
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
        XCTAssertTrue(paymentProviderMock.invokedFinishTransaction)
    }

    func test_thatIAPProviderAddsTransactionObserver() {
        // when
        iapProvider.addTransactionObserver(fallbackHandler: { _ in })

        // then
        XCTAssertTrue(paymentProviderMock.invokedFallbackHandler)
        XCTAssertTrue(paymentProviderMock.invokedAddTransactionObserver)
    }

    func test_thatIAPProviderRemovesTransactionObserver() {
        // when
        iapProvider.removeTransactionObserver()

        // then
        XCTAssertTrue(paymentProviderMock.invokedRemoveTransactionObserver)
    }

    func test_thatIAPProviderFetchesProducts_whenProducts() async throws {
        // given
        let productsMock = [SKProduct(), SKProduct(), SKProduct()]
        productProviderMock.stubbedFetchResult = .success(productsMock)

        // when
        let products = try await iapProvider.fetch(productIDs: .productIDs)

        // then
        XCTAssertEqual(productsMock, products)
    }

    func test_thatIAPProviderThrowsNoProductsError_whenProductsProductProviderReturnsError() async {
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

    func test_thatIAPProviderReturnsPaymentTransaction_whenProductsExist() {
        // given
        let paymentTransactionMock = PaymentTransactionMock()
        productProviderMock.stubbedFetchResult = .success([ProductMock()])
        paymentProviderMock.stubbedAddResult = (paymentQueueMock, .success(paymentTransactionMock))

        // when
        var transactionResult: PaymentTransaction?
        iapProvider.purchase(productID: .productID) { result in
            if case let .success(transaction) = result {
                transactionResult = transaction
            }
        }

        // then
        XCTAssertEqual(transactionResult?.skTransaction, paymentTransactionMock)
    }

    func test_thatIAPProviderReturnsError_whenAddingPaymentFailed() {
        // given
        productProviderMock.stubbedFetchResult = .success([ProductMock()])
        paymentProviderMock.stubbedAddResult = (paymentQueueMock, .failure(.unknown))

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

    func test_thatIAPProviderPurchasesForAProduct_whenProductsExist() async throws {
        // given
        let transactionMock = SKPaymentTransaction()
        productProviderMock.stubbedFetchResult = .success([ProductMock()])
        paymentProviderMock.stubbedAddResult = (paymentQueueMock, .success(transactionMock))

        // when
        let transactionResult = try await iapProvider.purchase(productID: .productID)

        // then
        XCTAssertEqual(transactionMock, transactionResult.skTransaction)
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

    func test_thatIAPProviderReturnsTransaction() {
        // given
        let transactionMock = SKPaymentTransaction()
        paymentProviderMock.stubbedFallbackHandlerResult = (paymentQueueMock, .success(transactionMock))

        // when
        var transactionResult: PaymentTransaction?
        iapProvider.addTransactionObserver { result in
            if case let .success(transaction) = result {
                transactionResult = transaction
            }
        }

        // then
        XCTAssertEqual(transactionResult?.skTransaction, transactionMock)
    }

    func test_thatIAPProviderReturnsError() {
        // given
        paymentProviderMock.stubbedFallbackHandlerResult = (paymentQueueMock, .failure(.unknown))

        // when
        var errorResult: Error?
        iapProvider.addTransactionObserver { result in
            if case let .failure(error) = result {
                errorResult = error
            }
        }

        // then
        XCTAssertEqual(errorResult as? NSError, IAPError.unknown as NSError)
    }
}

// MARK: - Constants

private extension String {
    static let receipt = "receipt"
    static let productID = "product_identifier"
}

private extension Set where Element == String {
    static let productIDs: Set<Element> = .init(arrayLiteral: "1", "2", "3")
}
