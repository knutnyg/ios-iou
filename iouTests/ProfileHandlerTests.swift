
import Foundation
import XCTest

class ProfileHandlerTests : TestBase {

    let runIntegrationTests = false

    func testGetImage(){

        let expectation = expectationWithDescription("promise")
        
        ProfileHandler.getImageForUser(user).onSuccess{image in
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

    func testUploadImage(){

        if runIntegrationTests == false {
            return
        }

        //The Bundle for your current class
        var bundle = NSBundle(forClass: self.dynamicType)
        var path = bundle.pathForResource("dog", ofType: "jpeg")!

        let expectation = expectationWithDescription("promise")

        var image : UIImage = UIImage(imageLiteral: path)

        UserHandler.uploadImage(token, image: image).onSuccess{response in
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
