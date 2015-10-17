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

    override func setUp() {
        super.setUp()
        user = User(name: "Knut Nygaard", shortName: "Knut", id: 3, photoUrl: "https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50", email:"knutnyg@gmail.com")
        users = [user]
        group = Group(members: users, id: 44, archived: false, created: NSDate(), description: "IOS", lastUpdated: NSDate(), creator: user)
    }
    
    func testFetchGroups(){
        let groupHandler:GroupHandler = GroupHandler()
        
        let expectation = expectationWithDescription("promise")
    
        groupHandler.getGroupsForUser()
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
    
    func testCreateGroup(){
        let groupHandler:GroupHandler = GroupHandler()
        
        let expectation = expectationWithDescription("promise")
        
        let inputGroup:Group = group
        
        groupHandler.createGroup(inputGroup)
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
    
//    {"id":40,"description":"testSheet1","creator":{"id":3,"photourl":"https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz:50","name":"Knut Nygaard","shortname":"Knut"},"archived":false,"created_at":"2015-10-17T10:00:07Z","updated_at":"2015-10-17T10:00:07Z","members":[{"id":3,"photourl":"https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50","name":"Knut Nygaard","shortname":"Knut"},{"id":1,"email":"eivinlar@stud.ntnu.no","name":"Eivind Siqveland Larsen","shortname":"Eivindss","photourl":"http://graph.facebook.com/10152424427376357/picture","label":"Eivind Siqveland Larsen"}]}
    
    func testEditGroup(){
        let groupHandler:GroupHandler = GroupHandler()
        
        let expectation = expectationWithDescription("promise")
        
        let group:Group = self.group
        let newUser = User(name: "Eivind Siqveland Larsen", shortName: "Eivindss", id: 1, photoUrl: "http://graph.facebook.com/10152424427376357/picture", email: "eivinlar@stud.ntnu.no")
        group.members.append(newUser)
        
        groupHandler.editGroup(group)
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
        
}
