//
// Created by Knut Nygaard on 15/11/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class SignUpHandlerTests: XCTestCase {

    var runIntegrationTests = false

    func testSignUpWithCorrectContent(){

        if runIntegrationTests == false {
            return
        }

        let expectation = expectationWithDescription("promise")

        let name = "Knut_test"
        let email = "knutnyg+test@gmail.com"
        let password = "Test1234"
        let confirm_password = "Test1234"

        SignUpHandler.signUp(name,email:email,password:password,confirm_password: confirm_password)
        .onSuccess{ id in
            XCTAssert(true)
            expectation.fulfill()
        }
        .onFailure{ error in
            XCTAssert(false)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5, handler: {error in
            XCTAssertNil(error, "Error")
        })
    }

    func testSignUpWithInvalidEmail(){

        let expectation = expectationWithDescription("promise")

        let name = "Knut_test"
        let email = "knutnyg+testgmail.com"
        let password = "Test1234"
        let confirm_password = "Test1234"

        SignUpHandler.signUp(name,email:email,password:password,confirm_password: confirm_password)
        .onSuccess{ id in
            XCTAssert(false)
            expectation.fulfill()
        }
        .onFailure{ error in
            XCTAssert(true)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5, handler: {error in
            XCTAssertNil(error, "Error")
        })
    }

}
