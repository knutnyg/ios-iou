
import Foundation
import XCTest

class SignUpHandlerTests: TestBase {

    var runIntegrationTests = false

    func testSignUpWithCorrectContent(){

        if runIntegrationTests == false {
            return
        }

        let expectation = expectationWithDescription("promise")

        let name = "Knut_auto_test"
        let email = "knutnyg+testauto@gmail.com"
        let password = config.valueForKey("password") as! String

        SignUpHandler.signUp(name,email:email,password:password,confirm_password: password)
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
        let password = "awd"

        SignUpHandler.signUp(name,email:email,password:password,confirm_password: password)
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
