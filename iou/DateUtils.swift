import Foundation


func dateFromUTCString(dateOnUTC:String) -> NSDate{
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    return dateFormatter.dateFromString(dateOnUTC)!
}