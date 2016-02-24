
import Foundation
import SwiftValidator

class IsNumericRule : RegexRule {

    static let regex = "\\d+[,.]?\\d+"

    convenience init(message : String = "Not a valid number"){
        self.init(regex: IsNumericRule.regex, message : message)
    }
}
