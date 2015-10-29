//
// Created by Knut Nygaard on 28/10/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation

class GroupTableHeaderViewController : UIViewController {

    var name:UILabel!
    var archivedLabel:UILabel!
    var archived:UISwitch!
    var delegate:MainViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()

        name = createLabel("Groups:")
        archivedLabel = createLabel("Show archived")
        archived = UISwitch()
        archived.translatesAutoresizingMaskIntoConstraints = false
        archived.setOn(false, animated: false)
        archived.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)

        view.addSubview(name)
        view.addSubview(archivedLabel)
        view.addSubview(archived)

        let views:[String:AnyObject] = ["name":name, "show_archived":archivedLabel, "archived":archived]

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[name]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[show_archived]-[archived]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[name]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[archived]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[show_archived]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

    }

    func buttonPressed(sender:UISwitch){
        if sender.on == true {
            delegate.groupListTableViewController.visibleGroups = delegate.groupListTableViewController.groups
        } else {
            delegate.groupListTableViewController.visibleGroups = delegate.groupListTableViewController.unArchivedGroups
        }
        delegate.groupListTableViewController.tableView.reloadData()
    }


}
