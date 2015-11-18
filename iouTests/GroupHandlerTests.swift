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
        token = "eyJpZCI6IjFhZjEwMmQ5LWMyMjQtNDUxYi1iNzkzLTdhMjM5YWYwOTgwNyIsInRva2VuX2lkIjoiIiwiZW1haWwiOiJrbnV0bnlnK3Rlc3RAZ21haWwuY29tIiwibmFtZSI6IktudXRfdGVzdCIsInNob3J0bmFtZSI6IiIsInBob3RvdXJsIjoiIiwic2VjcmV0IjoiMDIwZjQ0MGNmZmVlYmZmMGFjMzRkZmJmMWRiNDgzZjAyN2ExMjlmNTE5NGZlMzEwNWViM2JjMmQ2ZmQ4OGRhYiIsImNyZWF0ZWRfYXQiOiIyMDE1LTExLTE3VDE5OjM5OjUxLjg2NDQzNzUyNloifQ=="
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



}
