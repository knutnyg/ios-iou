//
//  ProfileHandlerTests.swift
//  iou
//
//  Created by Knut Nygaard on 22/11/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class ProfileHandlerTests : XCTestCase {
    
    
    func testGetImage(){
        
        
        let expectation = expectationWithDescription("promise")
        
        let user = User(name: "Knut Test", shortName: "Knut", id: "1af102d9-c224-451b-b793-7a239af09807", photoUrl: "https://www.logisk.org/api/users/photo/1af102d9-c224-451b-b793-7a239af09807", email: "knutnyg+test@gmail.com")
        
        API.getImageForUser(user).onSuccess{image in
            XCTAssert(true)
            expectation.fulfill()
        }.onFailure{error in
            XCTAssert(false)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: {error in
            XCTAssertNil(error, "Error")
        })
    }

}
