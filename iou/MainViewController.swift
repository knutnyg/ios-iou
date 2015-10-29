
import Foundation
import UIKit

class MainViewController : UIViewController {
    
    var profileView:ProfileViewController!
    var tableHeader:GroupTableHeaderViewController!
    var groupListTableViewController:GroupListTableViewController!
    var delegate:UIViewController!
    var label:UILabel!
    var settingsButton:UIButton!
    var settingsButtonItem:UIBarButtonItem!

    var addGroupButton:UIButton!
    var addGroupButtonItem:UIBarButtonItem!
    
    override func viewDidLoad(){
        
        setupNavigationBar()
    
        profileView = ProfileViewController()
        profileView.view.translatesAutoresizingMaskIntoConstraints = false
        
        groupListTableViewController = GroupListTableViewController()
        groupListTableViewController.delegate = self
        tableHeader = GroupTableHeaderViewController()
        tableHeader.delegate = self
        tableHeader.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChildViewController(profileView)
        self.addChildViewController(tableHeader)
        self.addChildViewController(groupListTableViewController)
        
        view.addSubview(profileView.view)
        view.addSubview(tableHeader.view)
        view.addSubview(groupListTableViewController.view)

        
        let views:[String : AnyObject] = ["profile":profileView.view,"group":groupListTableViewController.view, "tableHeader":tableHeader.view]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[profile(200)]-0-[tableHeader(40)]-0-[group]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[profile]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableHeader]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[group]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        API.getUser()
            .onSuccess{ user in
                    API.currentUser = user
            }
    }


    func setupNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor(netHex: 0x123add)
        
        let font = UIFont(name: "HelveticaNeue", size:28)!

        let attributes:[String : AnyObject] = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationItem.title = "Groups"
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        let verticalOffset = 1.5 as CGFloat;
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(verticalOffset, forBarMetrics: UIBarMetrics.Default)
        
        settingsButton = createfontAwesomeButton("\u{f013}")
        settingsButton.addTarget(self, action: "settings:", forControlEvents: UIControlEvents.TouchUpInside)
        settingsButtonItem = UIBarButtonItem(customView: settingsButton)

        addGroupButton = createfontAwesomeButton("\u{f067}")
        addGroupButton.addTarget(self, action: "addGroup:", forControlEvents: UIControlEvents.TouchUpInside)
        addGroupButtonItem = UIBarButtonItem(customView: addGroupButton)
        
        navigationItem.rightBarButtonItem = settingsButtonItem
        navigationItem.leftBarButtonItem = addGroupButtonItem
    }
    
    func settings(sender:UIButton){
        let vc = SettingsViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func addGroup(sender:UIButton){
        let vc = AddGroup()
        navigationController?.pushViewController(vc, animated: true)
    }
}
