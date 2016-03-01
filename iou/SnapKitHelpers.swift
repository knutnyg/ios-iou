import Foundation
import SnapKit

class SnapKitHelpers {

    static func setConstraints(view: UIView, components: [UIView], rules: [ConstraintRules]) {
        for i in 0 ... components.count - 1 {
            components[i].snp_makeConstraints() {
                (comp) -> Void in

                var marginTop = 0
                var marginBottom = 0
                var marginLeft = 0
                var marginRight = 0

                var constraints = rules[i]

                //Snap top
                if let margin = constraints.i_marginTop {
                    marginTop = margin
                }

                if let snap = constraints.i_snapTop {
                    comp.top.equalTo(snap).offset(marginTop)
                }

                //Height
                if let height = constraints.i_height {
                    comp.height.equalTo(height)
                }

                //CenterY
                if let _ = constraints.i_centerY {
                    comp.centerY.equalTo(view)
                }

                //Snap bottom
                if let margin = constraints.i_marginBottom {
                    marginBottom = margin
                }

                if let snap = constraints.i_snapBottom {
                    comp.bottom.equalTo(snap).offset(-marginBottom)
                }

                //Snap Left
                if let margin = constraints.i_marginLeft {
                    marginLeft = margin
                }

                if let snap = constraints.i_snapLeft {
                    comp.left.equalTo(snap).offset(marginLeft)
                }

                //Snap Right
                if let margin = constraints.i_marginRight {
                    marginRight = margin
                }

                if let snap = constraints.i_snapRight {
                    comp.right.equalTo(snap).offset(-marginRight)
                }

                //Width
                if let width = constraints.i_width {
                    comp.width.equalTo(width)
                }

                //CenterY
                if let centerX = constraints.i_centerX {
                    comp.centerX.equalTo(view.snp_centerX)
                }
            }
        }
    }

    static func updateConstraints(view: UIView, components: [UIView], rules: [ConstraintRules]) {
        for i in 0 ... components.count - 1 {
            components[i].snp_updateConstraints() {
                (comp) -> Void in

                var marginTop = 0
                var marginBottom = 0
                var marginLeft = 0
                var marginRight = 0

                var constraints = rules[i]

                //Snap top
                if let margin = constraints.i_marginTop {
                    marginTop = margin
                }

                if let snap = constraints.i_snapTop {
                    comp.top.equalTo(snap).offset(marginTop)
                }

                //Height
                if let height = constraints.i_height {
                    comp.height.equalTo(height)
                }

                //CenterY
                if let _ = constraints.i_centerY {
                    comp.centerY.equalTo(view)
                }

                //Snap bottom
                if let margin = constraints.i_marginBottom {
                    marginBottom = margin
                }

                if let snap = constraints.i_snapBottom {
                    comp.bottom.equalTo(snap).offset(-marginBottom)
                }

                //Snap Left
                if let margin = constraints.i_marginLeft {
                    marginLeft = margin
                }

                if let snap = constraints.i_snapLeft {
                    comp.left.equalTo(snap).offset(marginLeft)
                }

                //Snap Right
                if let margin = constraints.i_marginRight {
                    marginRight = margin
                }

                if let snap = constraints.i_snapRight {
                    comp.right.equalTo(snap).offset(-marginRight)
                }

                //Width
                if let width = constraints.i_width {
                    comp.width.equalTo(width)
                }

                //CenterY
                if let centerX = constraints.i_centerX {
                    comp.centerX.equalTo(view.snp_centerX)
                }
            }
        }
    }

    static func setConstraints(view: UIView, components: [ComponentWrapper]) {
        for i in 0 ... components.count - 1 {
            components[i].view.snp_makeConstraints() {
                (comp) -> Void in

                var marginTop = 0
                var marginBottom = 0
                var marginLeft = 0
                var marginRight = 0

                var constraints = components[i].rules

                //Snap top
                if let margin = constraints.i_marginTop {
                    marginTop = margin
                }

                if let snap = constraints.i_snapTop {
                    comp.top.equalTo(snap).offset(marginTop)
                }

                //Height
                if let height = constraints.i_height {
                    comp.height.equalTo(height)
                }

                //CenterY
                if let _ = constraints.i_centerY {
                    comp.centerY.equalTo(view)
                }

                //Snap bottom
                if let margin = constraints.i_marginBottom {
                    marginBottom = margin
                }

                if let snap = constraints.i_snapBottom {
                    comp.bottom.equalTo(snap).offset(-marginBottom)
                }

                //Snap Left
                if let margin = constraints.i_marginLeft {
                    marginLeft = margin
                }

                if let snap = constraints.i_snapLeft {
                    comp.left.equalTo(snap).offset(marginLeft)
                }

                //Snap Right
                if let margin = constraints.i_marginRight {
                    marginRight = margin
                }

                if let snap = constraints.i_snapRight {
                    comp.right.equalTo(snap).offset(-marginRight)
                }

                //Width
                if let width = constraints.i_width {
                    comp.width.equalTo(width)
                }

                //CenterY
                if let centerX = constraints.i_centerX {
                    comp.centerX.equalTo(view.snp_centerX)
                }
            }
        }
    }

    static func updateConstraints(view: UIView, components: [ComponentWrapper]) {
        for i in 0 ... components.count - 1 {
            components[i].view.snp_updateConstraints() {
                (comp) -> Void in

                var marginTop = 0
                var marginBottom = 0
                var marginLeft = 0
                var marginRight = 0

                var constraints = components[i].rules

                //Snap top
                if let margin = constraints.i_marginTop {
                    marginTop = margin
                }

                if let snap = constraints.i_snapTop {
                    comp.top.equalTo(snap).offset(marginTop)
                }

                //Height
                if let height = constraints.i_height {
                    comp.height.equalTo(height)
                }

                //CenterY
                if let _ = constraints.i_centerY {
                    comp.centerY.equalTo(view)
                }

                //Snap bottom
                if let margin = constraints.i_marginBottom {
                    marginBottom = margin
                }

                if let snap = constraints.i_snapBottom {
                    comp.bottom.equalTo(snap).offset(-marginBottom)
                }

                //Snap Left
                if let margin = constraints.i_marginLeft {
                    marginLeft = margin
                }

                if let snap = constraints.i_snapLeft {
                    comp.left.equalTo(snap).offset(marginLeft)
                }

                //Snap Right
                if let margin = constraints.i_marginRight {
                    marginRight = margin
                }

                if let snap = constraints.i_snapRight {
                    comp.right.equalTo(snap).offset(-marginRight)
                }

                //Width
                if let width = constraints.i_width {
                    comp.width.equalTo(width)
                }

                //CenterY
                if let centerX = constraints.i_centerX {
                    comp.centerX.equalTo(view.snp_centerX)
                }
            }
        }
    }
}
