//
// Created by Knut Nygaard on 20/11/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation

func normalizeNumberInText(input:String) -> NSString{
    return input.stringByReplacingOccurrencesOfString(",", withString: ".", options: NSStringCompareOptions.LiteralSearch, range: nil) as NSString
}