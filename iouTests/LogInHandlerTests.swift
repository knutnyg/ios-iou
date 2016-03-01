//
//  LogInHandlerTests.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class LogInHandlerTests : TestBase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testLogInDefault(){
        let username = config.valueForKey("username") as! String
        let password = config.valueForKey("password") as! String
        
        let expectation = expectationWithDescription("promise")

        LogInHandler().logInWithDefault(username, password: password)
            .onSuccess{ token in
                
                XCTAssertFalse(token.isEmpty)
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
