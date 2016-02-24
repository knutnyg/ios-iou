
import Foundation
import SnapKit

class VerticalConstraintRules {

    var height:Int?
    var marginTop:Int?
    var marginBottom:Int?
    var centerY:Bool?
    var snapTop:ConstraintItem?
    var snapBottom:ConstraintItem?

    func withHeight(height:Int?) -> VerticalConstraintRules {
        self.height = height
        return self
    }

    func withMarginTop(margin:Int) -> VerticalConstraintRules {
        self.marginTop = margin
        return self
    }

    func withMarginBottom(margin:Int) -> VerticalConstraintRules {
        self.marginBottom = margin
        return self
    }

    func withCenterY(centerY:Bool) -> VerticalConstraintRules {
        self.centerY = centerY
        return self
    }

    func withSnapTop(view:ConstraintItem) -> VerticalConstraintRules {
        self.snapTop = view
        return self
    }

    func withSnapBottom(view:ConstraintItem) -> VerticalConstraintRules {
        self.snapBottom = view
        return self
    }

}
