//
//  Extensions.swift
//  iou
//
//  Created by Knut Nygaard on 4/29/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension NSDate {
    
    func shortPrintable()-> String{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        
        return dateFormatter.stringFromDate(self)
    }
    
    func mediumPrintable() -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd. MMMM YYYY"
        
        return dateFormatter.stringFromDate(self)
    }
    
    func utcFormat() -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        return dateFormatter.stringFromDate(self)
    }
}

extension Array {
    func find(includedElement: T -> Bool) -> Int? {
        for (idx, element) in enumerate(self) {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
}