//
//  UserHandlerTests.swift
//  iou
//
//  Created by Knut Nygaard on 20/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest


class UserHandlerTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        API.accessToken = "eyJpZCI6MTYsImVtYWlsIjoia251dG55Zyt0ZXN0QGdtYWlsLmNvbSIsIm5hbWUiOiJ0ZXN0X0tudXQiLCJzaG9ydG5hbWUiOiIiLCJwaG90b3VybCI6IiIsInNlY3JldCI6ImFlZDExYzYwYTJiODBkZDkxYTA3NThkYWY2YTRjOTkwYWRhMzA5Y2Y2MWQxNzQ0NWQ3ODZjYTY3NzA3Yjk2MjAiLCJjcmVhdGVkX2F0IjoiMjAxNS0xMC0yMFQxODoyMDo1NS4wODE2MzY0NDlaIn0="
    }
    
    func testFetchUser(){
        
        let expectation = expectationWithDescription("promise")
        
        API.getUser()
            .onSuccess { user in
                XCTAssertTrue(user.id == 16)
                expectation.fulfill()
            }
            .onFailure { error in
                XCTAssert(false)
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
}