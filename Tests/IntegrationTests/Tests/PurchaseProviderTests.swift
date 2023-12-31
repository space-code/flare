//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

////
//// Flare
//// Copyright © 2023 Space Code. All rights reserved.
////
//
// @testable import Flare
// import XCTest
//
//// MARK: - PurchaseProviderStoreKit2Tests
//
// @available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
// final class PurchaseProviderStoreKit2Tests: StoreSessionTestCase {
//    // MARK: Properties
//
//    private var paymentProviderMock: PaymentProviderMock!
//
//    private var sut: PurchaseProvider!
//
//    // MARK: XCTestCase
//
//    override func setUp() {
//        super.setUp()
//        paymentProviderMock = PaymentProviderMock()
//        sut = PurchaseProvider(
//            paymentProvider: paymentProviderMock
//        )
//    }
//
//    override func tearDown() {
//        sut = nil
//        super.tearDown()
//    }
//
//    // MARK: Tests
//
//    func test_thatPurchaseProviderReturnsPaymentTransaction_whenPurchasesAProductWithOptions() async throws {
//        let expectation = XCTestExpectation(description: "Purchase a product")
//        let productMock = try StoreProduct(product: await ProductProviderHelper.purchases.randomElement()!)
//
//        // when
//        sut.purchase(product: productMock, options: [.simulatesAskToBuyInSandbox(false)]) { result in
//            switch result {
//            case let .success(transaction):
//                XCTAssertEqual(transaction.productIdentifier, productMock.productIdentifier)
//                expectation.fulfill()
//            case let .failure(error):
//                XCTFail(error.localizedDescription)
//            }
//        }
//
//        #if swift(>=5.9)
//            await fulfillment(of: [expectation])
//        #else
//            wait(for: [expectation], timeout: .second)
//        #endif
//    }
//
//    func test_thatPurchaseProviderReturnsPaymentTransaction_whenSK2ProductExist() async throws {
//        let expectation = XCTestExpectation(description: "Purchase a product")
//        let productMock = try StoreProduct(product: await ProductProviderHelper.purchases.randomElement()!)
//
//        // when
//        sut.purchase(product: productMock) { result in
//            switch result {
//            case let .success(transaction):
//                XCTAssertEqual(transaction.productIdentifier, productMock.productIdentifier)
//                expectation.fulfill()
//            case let .failure(error):
//                XCTFail(error.localizedDescription)
//            }
//        }
//
//        #if swift(>=5.9)
//            await fulfillment(of: [expectation])
//        #else
//            wait(for: [expectation], timeout: .second)
//        #endif
//    }
// }
//
//// MARK: - Constants
//
// private extension TimeInterval {
//    static let second: TimeInterval = 1.0
// }
