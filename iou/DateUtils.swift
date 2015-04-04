import Foundation

extension NSDate {
    
    func shortPrintable()-> String{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        
        return dateFormatter.stringFromDate(self)
    }
}