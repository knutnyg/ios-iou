import Foundation
import XCTest

class ResetPasswordHandlerTests: TestBase {

    let runIntegrationTests = false

    func testResetPassword() {

        if runIntegrationTests == false {
            return
        }

        let expectation = expectationWithDescription("promise")

        let email = config.valueForKey("username") as! String

        ResetPasswordHandler().resetPassword(email)
        .onSuccess {
            result in
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