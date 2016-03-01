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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testExpenseListFetch() {

        let expectation = expectationWithDescription("promise")

        GroupHandler.getGroup(APITests.token, group: group)
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

        let expectation = expectationWithDescription("promise")

        let expenseAmount = Double(arc4random_uniform(150))

        let expense = Expense(participants: [user], amount: expenseAmount, date: NSDate(), groupId: group.id, created: NSDate(), updated: NSDate(), comment: "Updated from test", creator: user, id: "1257f0ef-fc80-486b-901a-9fe609271fa1")

        ExpensesHandler.updateExpense(APITests.token, expense: expense)
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

        let expense = Expense(participants: [user], amount: 512, date: NSDate(), groupId: group.id, created: NSDate(), updated: NSDate(), comment: "Edited from test", creator: user, id: user.id)

        ExpensesHandler.deleteExpense(APITests.token, expense: expense)
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

    func testCreateUpdateAndDeleteExpense(){

        var expectation = expectationWithDescription("new")
        let newExpense = Expense(participants: [user], amount: 1337, date: NSDate(), groupId: group.id, created: NSDate(), updated: NSDate(), comment: "Receipe from test", creator: user)
        let editedExpense = Expense(participants: [user], amount: 512, date: NSDate(), groupId: group.id, created: NSDate(), updated: NSDate(), comment: "Edited from test", creator: user)

        //Create expense
        ExpensesHandler.newExpense(APITests.token, expense: newExpense)
        .onSuccess {
            expense in
            editedExpense.id = expense.id
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

        //Update expense
        expectation = expectationWithDescription("edit")

        ExpensesHandler.updateExpense(APITests.token, expense: editedExpense)
        .onSuccess {
            expense in
            XCTAssertTrue(expense.amount == 512)
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

        //Delete expense
        expectation = expectationWithDescription("delete")

        ExpensesHandler.deleteExpense(APITests.token, expense: editedExpense)
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

        ExpensesHandler.newExpense(APITests.token, expense: expense)
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