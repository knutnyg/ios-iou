//
//  APItests.swift
//  iou
//
//  Created by Knut Nygaard on 20/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class APITests : XCTestCase {

    override func setUp() {
        super.setUp()

    }

    func testGetProfileImageRealURL() {
        let expectation = expectationWithDescription("promise")

        let user = User(name: "Test Testson", shortName: "TT", id: "IDSareFUN", photoUrl: "https://graph.facebook.com/10152424427376357/picture", email:"nope@gmail.com")
        API.getImageForUser(user).onSuccess{image in
            print("yey")
            XCTAssert(true)
            expectation.fulfill()
        }.onFailure{err in
            print(err)
            XCTAssert(false)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func testGetProfileImageWrongURL() {
        let expectation = expectationWithDescription("promise")

        let user = User(name: "Test Testson", shortName: "TT", id: "IDSareFUN", photoUrl: "https://graph.facebook.comawdawd/picture", email:"nope@gmail.com")
        API.getImageForUser(user).onSuccess{image in
            print("yey")
            XCTAssert(false)
            expectation.fulfill()
        }.onFailure{err in
            print(err)
            XCTAssert(true)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func testGetProfileImageNoURL() {
        let expectation = expectationWithDescription("promise")

        let user = User(name: "Test Testson", shortName: "TT", id: "IDSareFUN", photoUrl: "", email:"nope@gmail.com")
        API.getImageForUser(user).onSuccess{image in
            print("yey")
            XCTAssert(false)
            expectation.fulfill()
        }.onFailure{err in
            print(err)
            XCTAssert(true)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
}
