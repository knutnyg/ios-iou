import Foundation
import UIKit
import SnapKit

class MainViewController: UIViewController {

    var profileView: ProfileViewController!
    var tableHeader: GroupTableHeaderViewController!
    var groupListTableViewController: GroupListTableViewController!

    var settingsButton: UIButton!
    var settingsButtonItem: UIBarButtonItem!

    var addGroupButton: UIButton!
    var addGroupButtonItem: UIBarButtonItem!

    override func viewDidLoad() {

        setupNavigationBar()

        profileView = ProfileViewController()
        tableHeader = GroupTableHeaderViewController()
        groupListTableViewController = GroupListTableViewController()

        tableHeader.delegate = self
        groupListTableViewController.delegate = self

        self.addChildViewController(profileView)
        self.addChildViewController(tableHeader)
        self.addChildViewController(groupListTableViewController)

        view.addSubview(profileView.view)
        view.addSubview(tableHeader.view)
        view.addSubview(groupListTableViewController.view)

        let components: [UIView] = [profileView.view, tableHeader.view, groupListTableViewController.view]
        let rules = [
                ConstraintRules()
                    .withSnapTop(view.snp_top)
                    .withMarginTop(64)
                    .withHeight(200)
                    .withSnapLeft(view.snp_left)
                    .withSnapRight(view.snp_right),
                ConstraintRules()
                    .withSnapTop(profileView.view.snp_bottom)
                    .withHeight(40)
                    .withSnapLeft(view.snp_left)
                    .withSnapRight(view.snp_right),
                ConstraintRules()
                    .withSnapTop(tableHeader.view.snp_bottom)
                    .withSnapLeft(view.snp_left)
                    .withSnapRight(view.snp_right)
                    .withSnapBottom(view.snp_bottom)
        ]

        SnapKitHelpers.setConstraints(view, components: components, rules: rules)

        API.getUser()
        .onSuccess {
            user in
            API.currentUser = user
            self.profileView.refreshProfile()
        }
    }

    func setupNavigationBar() {

        let font = UIFont(name: "HelveticaNeue", size: 28)!

        let attributes: [String:AnyObject] = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
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

    func settings(sender: UIButton) {
        let vc = SettingsViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func addGroup(sender: UIButton) {
        let vc = AddGroup()
        navigationController?.pushViewController(vc, animated: true)
    }
}
