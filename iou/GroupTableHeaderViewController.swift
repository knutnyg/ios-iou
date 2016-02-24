
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

        let rules = [
                ConstraintRules()
                    .withCenterY(true)
                    .withSnapLeft(view.snp_left)
                    .withMarginLeft(8),
                ConstraintRules()
                    .withCenterY(true)
                    .withSnapRight(archivedButton.snp_left)
                    .withMarginRight(8),
                ConstraintRules()
                    .withCenterY(true)
                    .withSnapRight(view.snp_right)
                    .withMarginRight(8)
        ]

        SnapKitHelpers.setConstraints(view, components: components, rules: rules)
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
