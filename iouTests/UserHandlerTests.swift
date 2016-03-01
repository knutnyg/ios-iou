
import Foundation
import XCTest


class UserHandlerTests : TestBase {
    
    func testFetchUser(){
        
        let expectation = expectationWithDescription("promise")
        
        UserHandler.getUser(token)
            .onSuccess { user in
                XCTAssertTrue(self.user.id == user.id)
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

    func testSearchUser(){
        let expectation = expectationWithDescription("promise")

        UserHandler.searchUser(token, query: "Knut")
        .onSuccess { users in
            XCTAssertTrue(users[0].id != nil)
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
    
    func testUpdateUser(){
        let expectation = expectationWithDescription("promise")
        
        let randomNumber = Int(arc4random_uniform(9))
        
        user.shortName = "Knut\(randomNumber)"
        
        UserHandler.updateUser(token, user: user)
            .onSuccess { response in
                XCTAssertTrue(response.shortName == "Knut\(randomNumber)")
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