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
        user = User(name: "Knut Nygaard", shortName: "Knut", id: 3, photoUrl: "https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50", email:"knutnyg@gmail.com")
        group = Group(members: [user], id: 26, archived: false, created: NSDate(), description: "IOS", lastUpdated: NSDate(), creator: user)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testExpenseListFetch(){
        let expensesHandler:ExpensesHandler = ExpensesHandler()
        
        let expectation = expectationWithDescription("promise")
        
        expensesHandler.getExpensesForGroup(group)
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
        let expensesHandler:ExpensesHandler = ExpensesHandler()
        
        let expectation = expectationWithDescription("promise")
        
        let expenseAmount = Double(arc4random_uniform(150))
        
        let expense = Expense(participants: [user], amount: expenseAmount, date: NSDate(), groupId: group.id, id: 338, created: NSDate(), updated: nil, comment: "Updated from test", creator: user)
        
        expensesHandler.updateExpense(expense)
            .onSuccess { expense in
                XCTAssertTrue(expense.amount == expenseAmount)
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