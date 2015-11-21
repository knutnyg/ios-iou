//
// Created by Knut Nygaard on 21/11/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import SwiftValidator

class IsNumericRule : RegexRule {

    static let regex = "^\\d{3}-\\d{2}-\\d{4}$"

    convenience init(message : String = "Not a valid SSN"){
        self.init(regex: SSNVRule.regex, message : message)
    }
}
