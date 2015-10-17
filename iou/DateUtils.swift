import Foundation


func dateFromUTCString(dateOnUTC:String) -> NSDate?{
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.dateFromString(dateOnUTC)
}