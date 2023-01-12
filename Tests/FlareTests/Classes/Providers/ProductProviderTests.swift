//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Concurrency
@testable import Flare
import StoreKit
import TestConcurrency
import XCTest

private extension String {
    static let requestId = "request_identifier"
}

private extension Set where Element == String {
    static let productIds: Set<Element> = .init(arrayLiteral: "1", "2", "3")
}

// MARK: - ProductProviderTests

class ProductProviderTests: XCTestCase {
    // MARK: - Properties

    private var testDispatchQueue: TestDispatchQueue!
    private var dispatchQueueFactory: IDispatchQueueFactory!
    private var productProvider: ProductProvider!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        testDispatchQueue = TestDispatchQueue()
        dispatchQueueFactory = TestDispatchQueueFactory(testQueue: testDispatchQueue)
        productProvider = ProductProvider(dispatchQueueFactory: dispatchQueueFactory)
    }

    override func tearDown() {
        testDispatchQueue = nil
        dispatchQueueFactory = nil
        productProvider = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testThatProductProviderFetchProductsWithInvalidProductsIdentfiers() {
        // given
        var fetchResult: Result<[SKProduct], IAPError>?
        let completionHandler: IProductProvider.ProductsHandler = { result in fetchResult = result }
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestId)
        let response = ProductResponseMock()

        response.stubbedInvokedInvalidProductsIdentifiers = ["111"]

        // when
        productProvider.fetch(productIds: .productIds, requestId: .requestId, completion: completionHandler)
        productProvider.productsRequest(request, didReceive: response)

        // then
        if case let .failure(error) = fetchResult, case let .invalid(products) = error {
            XCTAssertEqual(products, response.invalidProductIdentifiers)
        } else {
            XCTFail()
        }
    }

    func testThatProductProviderFetchProductsWithValidProductsIdentfiers() {
        // given
        var fetchResult: Result<[SKProduct], IAPError>?
        let completionHandler: IProductProvider.ProductsHandler = { result in fetchResult = result }
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestId)
        let response = ProductResponseMock()

        // when
        productProvider.fetch(productIds: .productIds, requestId: .requestId, completion: completionHandler)
        productProvider.productsRequest(request, didReceive: response)

        // then
        if case let .success(products) = fetchResult {
            XCTAssertEqual(products, response.products)
        } else {
            XCTFail()
        }
    }

    func testThatProductProviderHandleRequestError() {
        // given
        var fetchResult: Result<[SKProduct], IAPError>?
        let completionHandler: IProductProvider.ProductsHandler = { result in fetchResult = result }
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestId)
        let error = IAPError.emptyProducts

        // when
        productProvider.fetch(productIds: .productIds, requestId: .requestId, completion: completionHandler)
        productProvider.request(request, didFailWithError: error)

        // then
        if case let .failure(resultError) = fetchResult {
            XCTAssertEqual(resultError.plainError as NSError, error.plainError as NSError)
        } else {
            XCTFail()
        }
    }
}
