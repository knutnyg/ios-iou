import Foundation

func dateFromUTCString(dateOnUTC:String) -> NSDate?{
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    if let date = dateFormatter.dateFromString(dateOnUTC) {
        return date
    }
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
    
    if let date = dateFormatter.dateFromString(dateOnUTC) {
        return date
    }
    
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
    
    if let date = dateFormatter.dateFromString(dateOnUTC) {
        return date
    }
    
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    if let date = dateFormatter.dateFromString(dateOnUTC) {
        return date
    }
    
    return nil
}