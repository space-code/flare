//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

//////
////// Flare
////// Copyright © 2023 Space Code. All rights reserved.
//////
//
// @testable import Flare
// import XCTest
//
//// MARK: - IAPProviderStoreKit2Tests
//
// @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
// final class IAPProviderStoreKit2Tests: StoreSessionTestCase {
//    // MARK: - Properties
//
//    private var productProviderMock: ProductProviderMock!
//    private var purchaseProvider: PurchaseProviderMock!
//    private var refundProviderMock: RefundProviderMock!
//
//    private var sut: IIAPProvider!
//
//    // MARK: - XCTestCase
//
//    override func setUp() {
//        super.setUp()
//        productProviderMock = ProductProviderMock()
//        purchaseProvider = PurchaseProviderMock()
//        refundProviderMock = RefundProviderMock()
//        sut = IAPProvider(
//            paymentQueue: PaymentQueueMock(),
//            productProvider: productProviderMock,
//            purchaseProvider: purchaseProvider,
//            receiptRefreshProvider: ReceiptRefreshProviderMock(),
//            refundProvider: refundProviderMock
//        )
//    }
//
//    override func tearDown() {
//        productProviderMock = nil
//        purchaseProvider = nil
//        refundProviderMock = nil
//        sut = nil
//        super.tearDown()
//    }
//
//    // MARK: Tests
//
//    func test_thatIAPProviderFetchesSK2Products_whenProductsAreAvailable() async throws {
//        let productsMock = try await ProductProviderHelper.purchases.map(SK2StoreProduct.init)
//        productProviderMock.stubbedAsyncFetchResult = .success(productsMock)
//
//        // when
//        let products = try await sut.fetch(productIDs: [.productID])
//
//        // then
//        XCTAssertFalse(products.isEmpty)
//        XCTAssertEqual(productsMock.count, products.count)
//    }
//
//    func test_thatIAPProviderThrowsAnIAPError_whenFetchingProductsFailed() async {
//        productProviderMock.stubbedAsyncFetchResult = .failure(IAPError.unknown)
//
//        // when
//        let error: IAPError? = await error(for: { try await sut.fetch(productIDs: [.productID]) })
//
//        // then
//        XCTAssertEqual(error, .unknown)
//    }
//
//    func test_thatIAPProviderThrowsAPlainError_whenFetchingProductsFailed() async {
//        productProviderMock.stubbedAsyncFetchResult = .failure(URLError(.unknown))
//
//        // when
//        let error: IAPError? = await error(for: { try await sut.fetch(productIDs: [.productID]) })
//
//        // then
//        XCTAssertEqual(error, .with(error: URLError(.unknown)))
//    }
//
//    #if os(iOS) || VISION_OS
//        func test_thatIAPProviderRefundsPurchase() async throws {
//            // given
//            refundProviderMock.stubbedBeginRefundRequest = .success
//
//            // when
//            let state = try await sut.beginRefundRequest(productID: .productID)
//
//            // then
//            if case .success = state {}
//            else { XCTFail("state must be `success`") }
//        }
//
//        func test_thatFlareThrowsAnError_whenBeginRefundRequestFailed() async throws {
//            // given
//            refundProviderMock.stubbedBeginRefundRequest = .failed(error: IAPError.unknown)
//
//            // when
//            let state = try await sut.beginRefundRequest(productID: .productID)
//
//            // then
//            if case let .failed(error) = state { XCTAssertEqual(error as NSError, IAPError.unknown as NSError) }
//            else { XCTFail("state must be `failed`") }
//        }
//    #endif
//
//    func test_thatIAPProviderPurchasesAProduct() async throws {
//        // given
//        let transactionMock = StoreTransactionMock()
//        transactionMock.stubbedTransactionIdentifier = .transactionID
//
//        let storeTransaction = StoreTransaction(storeTransaction: transactionMock)
//        purchaseProvider.stubbedPurchaseCompletionResult = (.success(storeTransaction), ())
//
//        let product = try await ProductProviderHelper.purchases[0]
//
//        // when
//        let transaction = try await sut.purchase(product: StoreProduct(product: product))
//
//        // then
//        XCTAssertEqual(transaction.transactionIdentifier, .transactionID)
//    }
//
//    func test_thatIAPProviderPurchasesAProductWithOptions() async throws {
//        // given
//        let transactionMock = StoreTransactionMock()
//        transactionMock.stubbedTransactionIdentifier = .transactionID
//
//        let storeTransaction = StoreTransaction(storeTransaction: transactionMock)
//        purchaseProvider.stubbedinvokedPurchaseWithOptionsCompletionResult = (.success(storeTransaction), ())
//
//        let product = try await ProductProviderHelper.purchases[0]
//
//        // when
//        let transaction = try await sut.purchase(product: StoreProduct(product: product), options: [])
//
//        // then
//        XCTAssertEqual(transaction.transactionIdentifier, .transactionID)
//    }
// }
//
//// MARK: - Constants
//
// private extension String {
////    static let receipt = "receipt"
//    static let productID = "product_identifier"
//    static let transactionID = "transaction_identifier"
// }
