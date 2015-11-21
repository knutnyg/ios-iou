//
// Created by Knut Nygaard on 20/11/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class StringUtilsTests : XCTestCase{

    func testNormalizeNumberFromTextNormalNumberNoDecimal(){
        let numberAsString = "123"
        let number = normalizeNumberInText(numberAsString).doubleValue
        XCTAssertEqual(number, 123.0)
    }

    func testNormalizeNumberFromTextWithCommaDecimal(){
        let numberAsString = "123,4"
        let number = normalizeNumberInText(numberAsString).doubleValue
        XCTAssertEqual(number, 123.4)
    }

    func testNormalizeNumberFromTextWithDotDecimal(){
        let numberAsString = "123.4"
        let number = normalizeNumberInText(numberAsString).doubleValue
        XCTAssertEqual(number, 123.4)
    }

    func testNormalizeNumberFromTextWithMultipleSeparators(){
        let numberAsString = "123,23.23,23"
        let number = normalizeNumberInText(numberAsString).doubleValue
        XCTAssertEqual(number, 123.23)
    }

    func testNormalizeNumberFromTextWithInvalidNumber(){
        let numberAsString = "123awd,23"
        let number = normalizeNumberInText(numberAsString).doubleValue
        XCTAssertEqual(number, 123)
    }

    func testNormalizeNumberFromTextWithEmptyString(){
        let numberAsString = ""
        let number = normalizeNumberInText(numberAsString).doubleValue
        XCTAssertEqual(number, 0)
    }

}
