//
//  ExpenseTests.swift
//  iou
//
//  Created by Knut Nygaard on 5/1/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class ExpenseTests: TestBase {

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

    func testCreateUpdateAndDeleteExpense(){

        var expectation = expectationWithDescription("new")
        let newExpense = Expense(participants: [user], amount: 1337, date: NSDate(), groupId: group.id, created: NSDate(), updated: NSDate(), comment: "Receipe from test", creator: user)
        let editedExpense = Expense(participants: [user], amount: 512, date: NSDate(), groupId: group.id, created: NSDate(), updated: NSDate(), comment: "Edited from test", creator: user)

        //Create expense
        ExpensesHandler.newExpense(token, expense: newExpense)
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

        ExpensesHandler.updateExpense(token, expense: editedExpense)
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

        ExpensesHandler.deleteExpense(token, expense: editedExpense)
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