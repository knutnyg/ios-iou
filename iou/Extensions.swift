
import Foundation
import UIKit
import JSONJoy

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
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        
        return dateFormatter.stringFromDate(self)
    }
    
    func mediumPrintable() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd. MMMM YYYY"
        
        return dateFormatter.stringFromDate(self)
    }
    
    func utcFormat() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        return dateFormatter.stringFromDate(self)
    }

    func relativePrintable() -> String {
        let elapsedTime = self.timeIntervalSinceNow * -1
        if elapsedTime < 60 {
            return "\(Int(elapsedTime))s"
        } else if elapsedTime < 3600 {
            return "\(Int(elapsedTime / 60))m"
        } else if elapsedTime < 86400.0 {
            return "\(Int(elapsedTime / 3600))h"
        } else {
            return "\(Int(elapsedTime / 86400))d"
        }
    }
}