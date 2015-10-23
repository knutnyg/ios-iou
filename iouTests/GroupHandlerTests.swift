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

    override func setUp() {
        super.setUp()
        user = User(name: "Knut Nygaard", shortName: "Knut", id: 3, photoUrl: "https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50", email:"knutnyg@gmail.com")
        users = [user]
        group = Group(members: users, id: 44, archived: false, created: NSDate(), description: "IOS", lastUpdated: NSDate(), creator: user, expenses: [])
        token = "eyJpZCI6MywiZW1haWwiOiJrbnV0bnlnQGdtYWlsLmNvbSIsIm5hbWUiOiJLbnV0IE55Z2FhcmQiLCJzaG9ydG5hbWUiOiJLbnV0IiwicGhvdG91cmwiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLWYtaXBlRmVUY09vL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUV3L0NfcW9wRGxKb200L3Bob3RvLmpwZz9zej01MCIsInNlY3JldCI6IjJhN2U2ZGUzOGFiMDBiYmVmNTNhYzQxOGY3MmFiNGVjNDM1MzVkZmI0NDYyZTZiNjRkOWI0MWI4YWI4OGFmMGIiLCJjcmVhdGVkX2F0IjoiMjAxNS0wNC0wMlQwNTozMTowMy4zNTc0MjMxNFoifQ=="
    }
    
    func testFetchGroups(){
        let groupHandler:GroupHandler = GroupHandler()
        
        let expectation = expectationWithDescription("promise")
    
        groupHandler.getGroupsForUser(token)
            .onSuccess { groups in
                XCTAssertTrue(groups.count > 0)
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
        let groupHandler:GroupHandler = GroupHandler()
        
        let expectation = expectationWithDescription("promise")
        
        let inputGroup:Group = group
        
        groupHandler.createGroup(token, group: inputGroup)
            .onSuccess { outputGroup in
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
        let groupHandler:GroupHandler = GroupHandler()
        
        let expectation = expectationWithDescription("promise")
        
        let group:Group = self.group
        let newUser = User(name: "Eivind Siqveland Larsen", shortName: "Eivindss", id: 1, photoUrl: "http://graph.facebook.com/10152424427376357/picture", email: "eivinlar@stud.ntnu.no")
        group.members.append(newUser)
        
        groupHandler.putGroup(token, group:group)
            .onSuccess { return_group in
                XCTAssertTrue(group.members.map{member in return member.id}.contains(newUser.id))
                expectation.fulfill()
            }.onFailure { error in
                XCTAssert(false)
                expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")})
    }
    
    func testGuardForNilAccesstoken(){
        let groupHandler:GroupHandler = GroupHandler()
        
        let expectation = expectationWithDescription("promise")
        
        groupHandler.getGroupsForUser("Wrong Token")
            .onSuccess { groups in
                XCTAssert(false)
                expectation.fulfill()
            }.onFailure { error in
                XCTAssert(true)
                expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")})
    }
        
}
