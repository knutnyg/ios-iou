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
    var user:User!
    var group:Group!
    
        override func setUp() {
        super.setUp()
        user = User(name: "Knut Nygaard", shortName: "Knut", id: 3, photoUrl: "https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50")
        group = Group(members: [user], id: 26, archived: false, created: NSDate(), description: "IOS", lastUpdated: NSDate(), creator: user)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testExpenseListFetch(){
        let expensesListFetcher:ExpensesListFetcher = ExpensesListFetcher()
        
        let expectation = expectationWithDescription("promise")
        
        expensesListFetcher.getExpensesForGroup(group)
            .onSuccess { expenses in
                XCTAssertTrue(expenses.count > 0)
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
    
    func testExpenseUpdate(){
        let expensesListFetcher:ExpensesListFetcher = ExpensesListFetcher()
        
        let expectation = expectationWithDescription("promise")
        
        let expense = Expense(participants: [user], amount: 150, date: NSDate(), groupId: group.id, id: 338, created: NSDate(), updated: NSDate(), comment: "Updated in Test", creator: user)
        
        expensesListFetcher.updateExpense(expense)
            .onSuccess { expense in
                XCTAssertTrue(expense.comment.containsString("Updated"))
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