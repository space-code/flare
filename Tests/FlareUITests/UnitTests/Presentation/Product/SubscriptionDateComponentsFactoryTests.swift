//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import XCTest

final class SubscriptionDateComponentsFactoryTests: XCTestCase {
    // MARK: Private

    private var sut: SubscriptionDateComponentsFactory!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = SubscriptionDateComponentsFactory()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_thatDateComponentsFactoryCreatesDateCompoments_whenUnitIsDay() {
        // when
        let components = sut.dateComponents(for: .init(value: 10, unit: .day))

        // then
        XCTAssertEqual(components.day, 10)
    }

    func test_thatDateComponentsFactoryCreatesDateCompoments_whenUnitIsWeak() {
        // when
        let components = sut.dateComponents(for: .init(value: 10, unit: .week))

        // then
        XCTAssertEqual(components.weekOfMonth, 10)
    }

    func test_thatDateComponentsFactoryCreatesDateCompoments_whenUnitIsMonth() {
        // when
        let components = sut.dateComponents(for: .init(value: 10, unit: .month))

        // then
        XCTAssertEqual(components.month, 10)
    }

    func test_thatDateComponentsFactoryCreatesDateCompoments_whenUnitIsYear() {
        // when
        let components = sut.dateComponents(for: .init(value: 2010, unit: .year))

        // then
        XCTAssertEqual(components.year, 2010)
    }
}
