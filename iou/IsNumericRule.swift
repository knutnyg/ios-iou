//
// Created by Knut Nygaard on 21/11/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import SwiftValidator

class IsNumericRule : RegexRule {

    static let regex = "\\d+[,.]?\\d+"

    convenience init(message : String = "Not a valid number"){
        self.init(regex: IsNumericRule.regex, message : message)
    }
}
