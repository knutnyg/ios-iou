
import Foundation
import XCTest

class APITests : XCTestCase {

    static let token = "eyJpZCI6ImE2YzljNTkzLTI1YjEtNDEwMC05ZjE0LWRlNmMxYjQ2YTJlNCIsInRva2VuX2lkIjoiIiwiZW1haWwiOiJrbnV0bnlnK3Rlc3RAZ21haWwuY29tIiwibmFtZSI6IktudXQiLCJzaG9ydG5hbWUiOiIiLCJwaG90b3VybCI6Imh0dHBzOi8vd3d3LmxvZ2lzay5vcmcvYXBpL3VzZXJzL3Bob3RvL2E2YzljNTkzLTI1YjEtNDEwMC05ZjE0LWRlNmMxYjQ2YTJlNCIsInNlY3JldCI6IjYxMzY4ZDQ0Y2JkM2U1YTU4YmIyM2VjYTNkZTU2MDhlMTI2N2IyMWZlNjdlOTg3MTE4M2Y2MmNhNjc2YmEyYTEiLCJjcmVhdGVkX2F0IjoiMjAxNi0wMy0wMVQxMjo0NTo0Ni40NzYzNjA4NTdaIn0="
    static let user = User(name: "Knut", shortName: "Knut", id: "a6c9c593-25b1-4100-9f14-de6c1b46a2e4", photoUrl: "https://www.logisk.org/api/users/photo/a6c9c593-25b1-4100-9f14-de6c1b46a2e4", email: "knutnyg+test@gmail.com")
    static let group = Group(members: [user], id: "c1d3c321-e773-40a5-ad54-70ce2d2199c6", archived: false, created: NSDate(), description: "Test", lastUpdated: NSDate(), creator: user, expenses: [])

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
