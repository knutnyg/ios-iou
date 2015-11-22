//
//  ImageUtils.swift
//  iou
//
//  Created by Knut Nygaard on 22/11/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class ImageUtils {
    
    static func scaleImage(image:UIImage, height: CGFloat, width: CGFloat) -> UIImage{
        
        let rect = CGRectMake(0, 0, width, height)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width,height: height), false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

