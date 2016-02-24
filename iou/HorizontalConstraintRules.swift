
import Foundation

class HorizontalConstraintRules {

    var width:Int?
    var centerX:Bool?
    var anchorLeft:Bool?
    var anchorRight:Bool?
    var airLeft:Int?
    var airRight:Int?

    func withWidth(width:Int?) -> HorizontalConstraintRules {
        self.width = width
        return self
    }

    func withCenterX(centerX:Bool) -> HorizontalConstraintRules {
        self.centerX = centerX
        return self
    }

    func withAirLeft(air:Int) -> HorizontalConstraintRules {
        self.airLeft = air
        return self
    }

    func withAirRight(air:Int) -> HorizontalConstraintRules {
        self.airRight = air
        return self
    }

    func withAnchorLeft(anchorLeft:Bool) -> HorizontalConstraintRules {
        self.anchorLeft = anchorLeft
        return self
    }

    func withAnchorRight(anchorRight:Bool) -> HorizontalConstraintRules {
        self.anchorRight = anchorRight
        return self
    }

}
