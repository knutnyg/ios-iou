

import Foundation

class SnapKitHelpers {

    static func setVerticalConstraints(view:UIView, components:[UIView], rules:VerticalConstraintRules){
        for i in 0...components.count-1 {
            components[i].snp_makeConstraints() {
                (comp) -> Void in

                //Top Anchor
                if i == 0 {
                    comp.top.equalTo(view.snp_top).offset(rules.air[i])
                } else {
                    comp.top.equalTo(components[i-1].snp_bottom).offset(rules.air[i])
                }

                //Height
                if let height = rules.elements[i] {
                    comp.height.equalTo(height)
                }

                //Bottom Anchor
                if i == components.count-1 {
                    comp.bottom.equalTo(view.snp_bottom).offset(rules.after)
                }
            }
        }
    }

    static func setHorizontalConstraints(view:UIView, components:[UIView]){
        for component in components {
            component.snp_makeConstraints {
                (comp) -> Void in
                comp.left.equalTo(view)
                comp.right.equalTo(view)
            }
        }
    }
}
