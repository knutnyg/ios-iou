//
//  ImageUtilsTests.swift
//  iou
//
//  Created by Knut Nygaard on 22/11/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class ImageUtilsTests : XCTestCase {
    
    func testImageScale(){
        
        let image = UIImage(named: "meg.png")!
        
        print(image.size.height)
        print(image.size.width)
        
        let scaledImage = ImageUtils.scaleImage(image, height: 200, width: 200)
        
        print(scaledImage.size.height)
        print(scaledImage.size.width)
        
        
        XCTAssert(scaledImage.size.width == 200)
        
    }
    
}