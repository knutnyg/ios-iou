
import Foundation
import SnapKit

class HorizontalConstraintRules {

    var width:Int?
    var centerX:Bool?
    var marginLeft:Int?
    var marginRight:Int?
    var snapLeft:ConstraintItem?
    var snapRight:ConstraintItem?

    func withWidth(width:Int?) -> HorizontalConstraintRules {
        self.width = width
        return self
    }

    func withCenterX(centerX:Bool) -> HorizontalConstraintRules {
        self.centerX = centerX
        return self
    }

    func withMarginLeft(margin:Int) -> HorizontalConstraintRules {
        self.marginLeft = margin
        return self
    }

    func withMarginRight(margin:Int) -> HorizontalConstraintRules {
        self.marginRight = margin
        return self
    }

    func withSnapLeft(view:ConstraintItem) -> HorizontalConstraintRules {
        self.snapLeft = view
        return self
    }

    func withSnapRight(view:ConstraintItem) -> HorizontalConstraintRules {
        self.snapRight = view
        return self
    }
}
