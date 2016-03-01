//
//  GroupListFetcherTests.swift
//  iou
//
//  Created by Knut Nygaard on 15/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class GroupListFetcherTests : TestBase {

    func testFetchGroups(){

        let expectation = expectationWithDescription("promise")
    
        GroupHandler.getGroupsForUser(token)
            .onSuccess { groups in
                XCTAssert(true)
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

    func testCreateEditAndArchiveGroup(){
        //Create
        var expectation = expectationWithDescription("create")

        var createdGroup = Group()

        GroupHandler.createGroup(token, name: "Test Group", creator: user)
        .onSuccess { group in
            XCTAssertTrue(group.id != nil)
            createdGroup = group
            expectation.fulfill()
        }
        .onFailure { error in
            XCTAssert(false)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")})

        //Edit
        expectation = expectationWithDescription("edit")

        createdGroup.description = "Test Group edited!"

        GroupHandler.putGroup(token, group: createdGroup)
        .onSuccess { group in
            XCTAssertTrue(group.description == createdGroup.description)
            expectation.fulfill()
        }.onFailure { error in
            XCTAssert(false)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")})

        //Archive
        expectation = expectationWithDescription("archive")

        createdGroup.description = "Test-group-archived \(NSDate().shortPrintable())"
        createdGroup.archived = true

        GroupHandler.putGroup(token, group: createdGroup)
        .onSuccess { group in
            XCTAssertTrue(group.description == createdGroup.description)
            XCTAssertTrue(group.archived == true)
            expectation.fulfill()
        }.onFailure { error in
            XCTAssert(false)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")})


    }



}
