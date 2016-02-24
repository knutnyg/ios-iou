
import Foundation
import UIKit

class GroupTableHeaderViewController : UIViewController {

    var delegate:MainViewController!
    var titleLabel:UILabel!
    var archivedLabel:UILabel!
    var archivedButton:UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setArchiveButtonValue:", name: "setArchiveButtonValue", object: nil)

        view.backgroundColor = UIColor.whiteColor()

        titleLabel = createLabel("Groups:")
        archivedLabel = createLabel("Show archived")

        archivedButton = UISwitch()
        archivedButton.setOn(false, animated: false)
        archivedButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(archivedLabel)
        view.addSubview(archivedButton)

        let components:[UIView] = [titleLabel, archivedLabel, archivedButton]

        let verticalRules = [
                VerticalConstraintRules().withCenterY(true),
                VerticalConstraintRules().withCenterY(true),
                VerticalConstraintRules().withCenterY(true)
        ]
        let horizontalRules = [
                HorizontalConstraintRules().withSnapLeft(view.snp_left).withMarginLeft(8),
                HorizontalConstraintRules().withSnapRight(archivedButton.snp_left).withMarginRight(8),
                HorizontalConstraintRules().withSnapRight(view.snp_right).withMarginRight(8)
        ]

        SnapKitHelpers.setHorizontalConstraints(view, components: components, rules: horizontalRules)
        SnapKitHelpers.setVerticalConstraints(view, components: components, rules: verticalRules)
//
//        let views:[String:AnyObject] = ["name": titleLabel, "show_archived":archivedLabel, "archived": archivedButton]
//
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[name]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[show_archived]-[archived]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[name]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[archived]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[show_archived]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

    }

    func buttonPressed(sender:UISwitch){
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "buttonChanged", object: sender.on))
    }

    func setArchiveButtonValue(notification: NSNotification){
        let val = notification.object as! Bool
        archivedButton.setOn(val, animated: true)
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "buttonChanged", object: archivedButton.on))
    }
}
