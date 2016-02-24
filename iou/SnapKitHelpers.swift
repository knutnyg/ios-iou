

import Foundation

class SnapKitHelpers {

    static func setVerticalConstraints(view:UIView, components:[UIView], rules:VerticalConstraintRules){
        for i in 0...components.count-1 {
            components[i].snp_makeConstraints() {
                (comp) -> Void in

                var air = 0
                var after = 0

                //Top Anchor
                if let airs = rules.air {
                    air = airs[i]
                }

                if i == 0 {
                    comp.top.equalTo(view.snp_top).offset(air)
                } else {
                    comp.top.equalTo(components[i-1].snp_bottom).offset(air)
                }

                //Height
                if let heights = rules.height {
                    if let height = heights[i] {
                        comp.height.equalTo(height)
                    }
                }

                //Bottom Anchor
                if let a = rules.after {
                    after = a
                }

                if i == components.count-1 {
                    comp.bottom.equalTo(view.snp_bottom).offset(after)
                }
            }
        }
    }

    static func setHorizontalConstraints(view:UIView, components:[UIView], rules: HorizontalConstraintRules){
        for i in 0...components.count-1 {
            components[i].snp_makeConstraints() {
                (comp) -> Void in

                var air = 0

                //Width
                if let widths = rules.width {
                    if let width = widths[i] {
                        comp.width.equalTo(width)
                    }
                }

                //CenterX
                if let centerXs = rules.centerX {
                    if centerXs[i] == true {
                        comp.centerX.equalTo(view)
                    }
                }

                //Left/Right Anchor
                if let airs = rules.air {
                    air = airs[i]
                }
                if let anchorSides = rules.anchorSides{
                    if anchorSides[i] == true {
                        comp.left.equalTo(view).offset(air)
                        comp.right.equalTo(view).offset(-air)
                    }
                }
            }
        }
    }
}
