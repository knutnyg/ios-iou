
import Foundation

class VerticalConstraintRules {

    var height:[Int?]?
    var air:[Int]?
    var after:Int?

    func withHeight(height:[Int?]) -> VerticalConstraintRules {
        self.height = height
        return self
    }

    func withAir(air:[Int]) -> VerticalConstraintRules {
        self.air = air
        return self
    }

    func withAfter(after:Int) -> VerticalConstraintRules {
        self.after = after
        return self
    }

}
