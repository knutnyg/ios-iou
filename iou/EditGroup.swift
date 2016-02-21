
import Foundation
import UIKit

class EditGroup : UIViewController{
    
    var entryLabel:UILabel!
    var entryTextField:UITextField!
    var memberTable:AddMemberToGroupTableViewController!

    var delegate:GroupViewController!
    var searchResult:[User] = []
    var group:Group!

    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
        group = delegate.group

        entryLabel = createLabel("Search:")
        entryTextField = createTextField("start typing name...")
        entryTextField.addTarget(self, action: Selector("entryEdited:"), forControlEvents: UIControlEvents.EditingChanged)

        memberTable = AddMemberToGroupTableViewController()
        memberTable.delegate = self
        memberTable.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(entryLabel)
        view.addSubview(entryTextField)

        addChildViewController(memberTable)
        view.addSubview(memberTable.view)

        let views = ["entryLabel":entryLabel, "entryTextField":entryTextField, "memberTable":memberTable.view]

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[entryLabel(20)]-[entryTextField(40)]-[memberTable]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[entryLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[entryTextField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[memberTable]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }

    func entryEdited(sender:UITextField){

        API.searchUsers(sender.text!).onSuccess{users in
            self.searchResult = users
            self.memberTable.tableView.reloadData()
        }

    }
}
