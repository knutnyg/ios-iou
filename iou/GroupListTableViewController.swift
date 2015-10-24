//
//  GroupPanelViewController.swift
//  iou
//
//  Created by Knut Nygaard on 3/5/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class GroupListTableViewController : UITableViewController {
    
    var groups:[Group] = []
    var maxGroupItems = 0
    var activity:UIActivityIndicatorView!
    var delegate:UIViewController!
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        view.addSubview(activity)
        activity.bringSubviewToFront(view)
        
        API.getGroupsForUser().onSuccess { groups in
            self.groups = groups
            self.tableView.reloadData()
            self.activity.stopAnimating()
        }
        self.activity.startAnimating()
        
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Groups:"
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //
            //Archive
            print("archive")
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "groupCell")
        cell.textLabel?.text = self.groups[indexPath.item].description
        cell.detailTextLabel?.text = "Last entry: 10h"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        API.currentGroup = groups[indexPath.item]
        let vc = GroupViewController()

        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Find max size
        return self.groups.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func viewDidLayoutSubviews() {
        positionSpinnerInMiddle()
    }
    
    func positionSpinnerInMiddle(){
        let x = view.bounds.width / 2
        let y = view.bounds.height / 2
        activity.center = CGPoint(x: x, y: y)
    }
}