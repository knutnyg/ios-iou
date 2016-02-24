
import Foundation

class VerticalConstraintRules {

    var elements:[Int?]!
    var air:[Int]!
    var after:Int!

    func withElements(elements:[Int?]) -> VerticalConstraintRules {
        self.elements = elements
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
