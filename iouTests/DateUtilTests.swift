//
//  DateUtilTests.swift
//  iou
//
//  Created by Knut Nygaard on 17/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class DateUtilTests : XCTestCase {
    
    override func setUp() {
        
    }
    
    func testDateWithThreeDecimalsFromUTCString() {
        let dateString = "2015-11-17T20:11:30.902Z"
        
        XCTAssertNotNil(dateFromUTCString(dateString))
    }
    
    func testDateWithNoDecimalsFromUTCString() {
        let dateString = "2015-11-17T20:11:30Z"
        
        XCTAssertNotNil(dateFromUTCString(dateString))
    }
    
    func testDateWithOneDecimalsFromUTCString() {
        let dateString = "2015-11-17T20:11:30.9Z"
        
        XCTAssertNotNil(dateFromUTCString(dateString))
    }
    
    func testDateWithTwoDecimalsFromUTCString() {
        let dateString = "2015-11-17T20:11:30.90Z"
        
        XCTAssertNotNil(dateFromUTCString(dateString))
    }


}