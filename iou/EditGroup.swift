
import Foundation

class EditGroup : UIViewController{
    
    var entryLabel:UILabel!
    var entryTextField:UITextField!
    var memberTable:AddMemberTableViewController!

    var delegate:UIViewController!
    var group:Group!
    var searchResult:[User] = []
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
        
        entryLabel = createLabel("Search:")
        entryTextField = createTextField("start typing name...")
        entryTextField.addTarget(self, action: Selector("entryEdited:"), forControlEvents: UIControlEvents.EditingChanged)

        
        memberTable = AddMemberTableViewController()
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
    
    init(group:Group){
        super.init(nibName: nil, bundle: nil)
        self.group = group
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
