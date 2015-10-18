//
//  ResetPasswordHandlerTests.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class ResetPasswordHandlerTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testResetPassword(){
        let expectation = expectationWithDescription("promise")
        
        let email = "knutnyg+test@gmail.com"
        
        ResetPasswordHandler().resetPassword(email)
            .onSuccess{ result in
                XCTAssert(true)
                expectation.fulfill()
            }
            .onFailure{ error in
                XCTAssert(false)
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: {error in
            XCTAssertNil(error, "Error")
        })
    }
}