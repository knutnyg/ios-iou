//
//  ExpenseTests.swift
//  iou
//
//  Created by Knut Nygaard on 5/1/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class ExpenseTests : XCTestCase {

    var users:[User]!
    
    override func setUp() {
        super.setUp()
        users = createMembers()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testToJSON(){
        
        var expense = Expense(participants: users, amount: 10.0, date: NSDate(), groupId: 0, id: 0, created: NSDate(), updated: NSDate(), comment: "a comment", creator: users[0])
        println(expense.toJSONparsableDicitonary())
    }
    
    func createMembers() -> [User] {
        var user1 = User(name: "User 1", shortName: "1", id: 0, photoUrl: "url")
        var user2 = User(name: "User 2", shortName: "2", id: 1, photoUrl: "url")
        var user3 = User(name: "User 3", shortName: "3", id: 2, photoUrl: "url")
        var user4 = User(name: "User 4", shortName: "4", id: 3, photoUrl: "url")
        
        return [user1, user2, user3, user4]
    }
}