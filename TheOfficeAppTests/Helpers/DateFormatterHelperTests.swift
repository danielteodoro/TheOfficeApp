//
//  DateFormatterHelperTests.swift
//  TheOfficeAppTests
//
//  Created by Daniel Teodoro on 26/11/20.
//

import XCTest
@testable import TheOfficeApp

class DateFormatterHelperTests: XCTestCase {

    func testformatDate() {
        let rawDateString = "2005-03-29T06:00:00.000Z"
        let formattedString = DateFormatterHelper().formatDate(from: rawDateString)
        XCTAssertEqual(formattedString, "Mar 29, 2005")
    }

}
