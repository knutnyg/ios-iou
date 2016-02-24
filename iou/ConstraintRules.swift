//
// Created by Knut Nygaard on 24/02/16.
// Copyright (c) 2016 APM solutions. All rights reserved.
//

import Foundation
import SnapKit

class ConstraintRules {

    var height:Int?
    var marginTop:Int?
    var marginBottom:Int?
    var centerY:Bool?
    var snapTop:ConstraintItem?
    var snapBottom:ConstraintItem?

    var width:Int?
    var centerX:Bool?
    var marginLeft:Int?
    var marginRight:Int?
    var snapLeft:ConstraintItem?
    var snapRight:ConstraintItem?

    func withHeight(height:Int?) -> ConstraintRules {
        self.height = height
        return self
    }

    func withMarginTop(margin:Int) -> ConstraintRules {
        self.marginTop = margin
        return self
    }

    func withMarginBottom(margin:Int) -> ConstraintRules {
        self.marginBottom = margin
        return self
    }

    func withCenterY(centerY:Bool) -> ConstraintRules {
        self.centerY = centerY
        return self
    }

    func withSnapTop(view:ConstraintItem) -> ConstraintRules {
        self.snapTop = view
        return self
    }

    func withSnapBottom(view:ConstraintItem) -> ConstraintRules {
        self.snapBottom = view
        return self
    }

    func withWidth(width:Int?) -> ConstraintRules {
        self.width = width
        return self
    }

    func withCenterX(centerX:Bool) -> ConstraintRules {
        self.centerX = centerX
        return self
    }

    func withMarginLeft(margin:Int) -> ConstraintRules {
        self.marginLeft = margin
        return self
    }

    func withMarginRight(margin:Int) -> ConstraintRules {
        self.marginRight = margin
        return self
    }

    func withSnapLeft(view:ConstraintItem) -> ConstraintRules {
        self.snapLeft = view
        return self
    }

    func withSnapRight(view:ConstraintItem) -> ConstraintRules {
        self.snapRight = view
        return self
    }
}
