import Foundation
import SnapKit

class SnapKitHelpers {

    static func setVerticalConstraints(view: UIView, components: [UIView], rules:[VerticalConstraintRules]) {
        for i in 0 ... components.count - 1 {
            components[i].snp_makeConstraints() {
                (comp) -> Void in

                var marginTop = 0
                var marginBottom = 0

                var constraints = rules[i]

                //Snap top
                if let margin = constraints.marginTop {
                    marginTop = margin
                }

                if let snap = constraints.snapTop {
                    comp.top.equalTo(snap).offset(marginTop)
                }

                //Height
                if let height = constraints.height {
                    comp.height.equalTo(height)
                }

                //CenterY
                if let _ = constraints.centerY {
                    comp.centerY.equalTo(view)
                }

                //Snap bottom
                if let margin = constraints.marginBottom {
                    marginBottom = margin
                }

                if let snap = constraints.snapBottom {
                    comp.bottom.equalTo(snap).offset(-marginBottom)
                }
            }
        }
    }

    static func updateVerticalConstraints(view: UIView, components: [UIView], rules:[VerticalConstraintRules]) {
        for i in 0 ... components.count - 1 {
            components[i].snp_updateConstraints() {
                (comp) -> Void in

                var marginTop = 0
                var marginBottom = 0

                var constraints = rules[i]

                //Snap top
                if let margin = constraints.marginTop {
                    marginTop = margin
                }

                if let snap = constraints.snapTop {
                    comp.top.equalTo(snap).offset(marginTop)
                }

                //Height
                if let height = constraints.height {
                    comp.height.equalTo(height)
                }

                //CenterY
                if let _ = constraints.centerY {
                    comp.centerY.equalTo(view)
                }

                //Snap bottom
                if let margin = constraints.marginBottom {
                    marginBottom = margin
                }

                if let snap = constraints.snapBottom {
                    comp.bottom.equalTo(snap).offset(-marginBottom)
                }
            }
        }
    }

    static func setHorizontalConstraints(view: UIView, components: [UIView], rules:[HorizontalConstraintRules]) {
        for i in 0 ... components.count - 1 {
            components[i].snp_makeConstraints() {
                (comp) -> Void in

                var marginLeft = 0
                var marginRight = 0

                let constraints = rules[i]

                //Snap Left
                if let margin = constraints.marginLeft {
                    marginLeft = margin
                }

                if let snap = constraints.snapLeft {
                    comp.left.equalTo(snap).offset(marginLeft)
                }

                //Snap Right
                if let margin = constraints.marginRight {
                    marginRight = margin
                }

                if let snap = constraints.snapRight {
                    comp.right.equalTo(snap).offset(-marginRight)
                }

                //Width
                if let width = constraints.width {
                    comp.width.equalTo(width)
                }

                //CenterY
                if let centerX = constraints.centerX {
                    comp.centerX.equalTo(view.snp_centerX)
                }
            }
        }
    }
}
