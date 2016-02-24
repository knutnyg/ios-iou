

import Foundation

func normalizeNumberInText(input:String) -> NSString{
    return input.stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil) as NSString
}