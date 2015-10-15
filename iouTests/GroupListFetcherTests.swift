//
//  GroupListFetcherTests.swift
//  iou
//
//  Created by Knut Nygaard on 15/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class GroupListFetcherTests : XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    func testGroupListFetch(){
        let groupListFetcher:GroupListFetcher = GroupListFetcher()
        
        let expectation = expectationWithDescription("promise")
    
        groupListFetcher.getGroupsForUser()
            .onSuccess { groups in
                XCTAssertTrue(groups.count > 3)
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