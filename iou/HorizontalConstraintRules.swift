
import Foundation

class HorizontalConstraintRules {

    var width:[Int?]?
    var centerX:[Bool]?
    var anchorSides:[Bool]?
    var air:[Int]?

    func withWidth(width:[Int?]) -> HorizontalConstraintRules {
        self.width = width
        return self
    }

    func withCenterX(centerX:[Bool]) -> HorizontalConstraintRules {
        self.centerX = centerX
        return self
    }

    func withAir(air:[Int]) -> HorizontalConstraintRules {
        self.air = air
        return self
    }

    func withAnchorSides(anchorSides:[Bool]) -> HorizontalConstraintRules {
        self.anchorSides = anchorSides
        return self
    }

}
