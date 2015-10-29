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
    var token:String!
    
    override func setUp() {
        super.setUp()
        user = User(name: "Knut Nygaard", shortName: "Knut", id: 3, photoUrl: "https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50", email:"knutnyg@gmail.com")
        group = Group(members: [user], id: 26, archived: false, created: NSDate(), description: "IOS", lastUpdated: NSDate(), creator: user, expenses:[])
        token = "eyJpZCI6MywiZW1haWwiOiJrbnV0bnlnQGdtYWlsLmNvbSIsIm5hbWUiOiJLbnV0IE55Z2FhcmQiLCJzaG9ydG5hbWUiOiJLbnV0IiwicGhvdG91cmwiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLWYtaXBlRmVUY09vL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUV3L0NfcW9wRGxKb200L3Bob3RvLmpwZz9zej01MCIsInNlY3JldCI6IjJhN2U2ZGUzOGFiMDBiYmVmNTNhYzQxOGY3MmFiNGVjNDM1MzVkZmI0NDYyZTZiNjRkOWI0MWI4YWI4OGFmMGIiLCJjcmVhdGVkX2F0IjoiMjAxNS0wNC0wMlQwNTozMTowMy4zNTc0MjMxNFoifQ=="
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testExpenseListFetch(){
        
        let expectation = expectationWithDescription("promise")
        
        API.getAllGroupData(group)
            .onSuccess { group in
                XCTAssertTrue(group.expenses.count > 0)
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
        
        let expense = Expense(participants: [user], amount: expenseAmount, date: NSDate(), groupId: group.id, created: NSDate(), updated: nil, comment: "Updated from test", creator: user, id: 338)
        
        expensesHandler.updateExpense(token, expense: expense)
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

    func testDeleteExpense(){

        let expectation = expectationWithDescription("promise")

        let expense = Expense(participants: [user], amount: 0, date: NSDate(), groupId: group.id, created: NSDate(), updated: nil, comment: "Deleted from test", creator: user, id: 343)

        ExpensesHandler().deleteExpense(token, expense: expense)
        .onSuccess { success in
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


}