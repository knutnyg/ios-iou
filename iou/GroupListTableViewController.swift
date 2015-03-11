//
//  GroupPanelViewController.swift
//  iou
//
//  Created by Knut Nygaard on 3/5/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class GroupListTableViewController : UITableViewController, GroupViewDelegate {
    
    var group:[(String, Int)] = []
    var maxGroupItems = 0
    var activity:UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blueColor()
        self.tableView.registerClass(GroupCell.self, forCellReuseIdentifier: "groupCell")
        
        activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        view.addSubview(activity)
        activity.bringSubviewToFront(view)
        
        //fetch group.
        GroupHandler.getGroups4Reals().onSuccess { group in
            self.group = group
            self.tableView.reloadData()
            self.activity.stopAnimating()
        }
        self.activity.startAnimating()
        
    }
    
    func didFinishGroup(controller: GroupListPanel) {
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellIdentifier:String = "groupCell"
        
        var cell:GroupCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as GroupCell
        cell.groupName.text = group[indexPath.item].0
        cell.memberCount.text = String(group[indexPath.item].1)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = GroupViewParent()
        vc.delegate = self
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(vc, animated: true, completion: nil)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Find max size
        return self.group.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    override func viewDidLayoutSubviews() {
        positionSpinnerInMiddle()
    }
    
    func positionSpinnerInMiddle(){
        var x = view.bounds.width / 2
        var y = view.bounds.height / 2
        activity.center = CGPoint(x: x, y: y)
    }
}