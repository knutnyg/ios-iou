//
//  UserHandlerTests.swift
//  iou
//
//  Created by Knut Nygaard on 20/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest


class UserHandlerTests : XCTestCase {
    
    var token:String!
    
    override func setUp() {
        super.setUp()
        API.accessToken = "eyJpZCI6IjFhZjEwMmQ5LWMyMjQtNDUxYi1iNzkzLTdhMjM5YWYwOTgwNyIsInRva2VuX2lkIjoiIiwiZW1haWwiOiJrbnV0bnlnK3Rlc3RAZ21haWwuY29tIiwibmFtZSI6IktudXRfdGVzdCIsInNob3J0bmFtZSI6IiIsInBob3RvdXJsIjoiIiwic2VjcmV0IjoiMDIwZjQ0MGNmZmVlYmZmMGFjMzRkZmJmMWRiNDgzZjAyN2ExMjlmNTE5NGZlMzEwNWViM2JjMmQ2ZmQ4OGRhYiIsImNyZWF0ZWRfYXQiOiIyMDE1LTExLTE3VDE5OjM5OjUxLjg2NDQzNzUyNloifQ=="
        token = "eyJpZCI6IjFhZjEwMmQ5LWMyMjQtNDUxYi1iNzkzLTdhMjM5YWYwOTgwNyIsInRva2VuX2lkIjoiIiwiZW1haWwiOiJrbnV0bnlnK3Rlc3RAZ21haWwuY29tIiwibmFtZSI6IktudXRfdGVzdCIsInNob3J0bmFtZSI6IiIsInBob3RvdXJsIjoiIiwic2VjcmV0IjoiMDIwZjQ0MGNmZmVlYmZmMGFjMzRkZmJmMWRiNDgzZjAyN2ExMjlmNTE5NGZlMzEwNWViM2JjMmQ2ZmQ4OGRhYiIsImNyZWF0ZWRfYXQiOiIyMDE1LTExLTE3VDE5OjM5OjUxLjg2NDQzNzUyNloifQ=="
        
    }
    
    func testFetchUser(){
        
        let expectation = expectationWithDescription("promise")
        
        API.getUser()
            .onSuccess { user in
                XCTAssertTrue(user.id == "1af102d9-c224-451b-b793-7a239af09807")
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

        API.searchUsers("Knut")
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
    
    func testUploadPhoto(){
        let expectation = expectationWithDescription("promise")
        
        let image = UIImage(named: "meg.png")!
        
        API.uploadImageForUser(image)
            .onSuccess { response in
                XCTAssertTrue(response.success! == true)
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
        
        let user = User(name: "Knut_test", shortName: "Knut\(randomNumber)", id: "1af102d9-c224-451b-b793-7a239af09807", photoUrl: "", email: "knutnyg+test@gmail.com")
        
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