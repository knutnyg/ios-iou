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
    
    var users:[User]!
    var user:User!
    var group:Group!
    var token:String!

    var runIntegrationTests = false

    override func setUp() {
        super.setUp()
        user = User(name: "Knut Nygaard", shortName: "Knut", id: "1af102d9-c224-451b-b793-7a239af09807", photoUrl: "https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50", email:"knutnyg@gmail.com")
        users = [user]
        group = Group(members: users, id: "dc0d4b89-4cfb-4c99-8a25-3ac39e6ff559", archived: false, created: NSDate(), description: "IOS", lastUpdated: NSDate(), creator: user, expenses: [])
        token = APITests.token
    }
    
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
    
    func testCreateGroup(){

        print("testing createa group")

        if runIntegrationTests == false {
            return
        }
        
        let expectation = expectationWithDescription("promise")
        
        let inputGroup:Group = group
        
        GroupHandler.createGroup(token, name: group.description, creator: group.creator)
            .onSuccess { outputGroup in
                print("made groups")
                XCTAssertTrue(outputGroup.id != nil)
                XCTAssertTrue(outputGroup.description == inputGroup.description)
                expectation.fulfill()
            }
            .onFailure { error in
                XCTAssert(false)
                expectation.fulfill()
            }
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")})
    }

    func testEditGroup(){

        if runIntegrationTests == false {
            return
        }

        let expectation = expectationWithDescription("promise")

        let group:Group = self.group
        group.description = "Test-group-" + NSDate().shortPrintable()

        GroupHandler.putGroup(token, group:group)
            .onSuccess { return_group in
                XCTAssertTrue(group.description == return_group.description)
                expectation.fulfill()
            }.onFailure { error in
                XCTAssert(false)
                expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")})
    }

    func testCreateEditAndArchiveGroup(){
        //Create
        var expectation = expectationWithDescription("create")

        var createdGroup = Group()

        GroupHandler.createGroup(APITests.token, name: "Test Group", creator: APITests.user)
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

        GroupHandler.putGroup(APITests.token, group: createdGroup)
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

        GroupHandler.putGroup(APITests.token, group: createdGroup)
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
