//
//  ExpenseTests.swift
//  iou
//
//  Created by Knut Nygaard on 5/1/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class ExpenseTests: XCTestCase {

    var users: [User]!
    var user: User!
    var group: Group!
    var token: String!

    var runIntegrationTests = false

    override func setUp() {
        super.setUp()
        user = User(name: "Knut Nygaard", shortName: "Knut", id: "1af102d9-c224-451b-b793-7a239af09807", photoUrl: "https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50", email: "knutnyg@gmail.com")
        group = Group(members: [user], id: "dc0d4b89-4cfb-4c99-8a25-3ac39e6ff559", archived: false, created: NSDate(), description: "IOS", lastUpdated: NSDate(), creator: user, expenses: [])
        token = "eyJpZCI6IjFhZjEwMmQ5LWMyMjQtNDUxYi1iNzkzLTdhMjM5YWYwOTgwNyIsInRva2VuX2lkIjoiIiwiZW1haWwiOiJrbnV0bnlnK3Rlc3RAZ21haWwuY29tIiwibmFtZSI6IktudXRfdGVzdCIsInNob3J0bmFtZSI6IiIsInBob3RvdXJsIjoiIiwic2VjcmV0IjoiMDIwZjQ0MGNmZmVlYmZmMGFjMzRkZmJmMWRiNDgzZjAyN2ExMjlmNTE5NGZlMzEwNWViM2JjMmQ2ZmQ4OGRhYiIsImNyZWF0ZWRfYXQiOiIyMDE1LTExLTE3VDE5OjM5OjUxLjg2NDQzNzUyNloifQ=="
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testExpenseListFetch() {

        let expectation = expectationWithDescription("promise")

        GroupHandler.getGroup(token, group: group)
        .onSuccess {
            group in
            XCTAssert(true)
            expectation.fulfill()
        }
        .onFailure {
            error in
            XCTAssert(false)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5, handler: {
            error in
            XCTAssertNil(error, "Error")
        })
    }

    func testExpenseUpdate() {
        if runIntegrationTests == false {
            return
        }
        let expensesHandler: ExpensesHandler = ExpensesHandler()

        let expectation = expectationWithDescription("promise")

        let expenseAmount = Double(arc4random_uniform(150))

        let expense = Expense(participants: [user], amount: expenseAmount, date: NSDate(), groupId: group.id, created: NSDate(), updated: NSDate(), comment: "Updated from test", creator: user, id: "1257f0ef-fc80-486b-901a-9fe609271fa1")

        expensesHandler.updateExpense(token, expense: expense)
        .onSuccess {
            expense in
            XCTAssertTrue(expense.amount == expenseAmount)
            expectation.fulfill()
        }
        .onFailure {
            error in
            XCTAssert(false)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5, handler: {
            error in
            XCTAssertNil(error, "Error")
        })
    }

    func testDeleteExpense() {
        if runIntegrationTests == false {
            return
        }

        let expectation = expectationWithDescription("promise")

        let expense = Expense(participants: [user], amount: 0, date: NSDate(), groupId: group.id, created: NSDate(), updated: nil, comment: "Deleted from test", creator: user, id: "95c26862-97a0-42d6-877b-0535e62cc2a1")

        ExpensesHandler().deleteExpense(token, expense: expense)
        .onSuccess {
            success in
            XCTAssert(true)
            expectation.fulfill()
        }
        .onFailure {
            error in
            XCTAssert(false)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5, handler: {
            error in
            XCTAssertNil(error, "Error")
        })
    }

    func testCreateExpense() {

        if runIntegrationTests == false {
            return
        }

        let expectation = expectationWithDescription("promise")

        let expense = Expense(participants: [user], amount: 0, date: NSDate(), groupId: group.id, created: NSDate(), updated: NSDate(), comment: "Receipe from test", creator: user, id: "1af102d9-c224-451b-b793-7a239af09807")

        ExpensesHandler().newExpense(token, expense: expense)
        .onSuccess {
            success in
            XCTAssert(true)
            expectation.fulfill()
        }
        .onFailure {
            error in
            XCTAssert(false)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5, handler: {
            error in
            XCTAssertNil(error, "Error")
        })
    }


}