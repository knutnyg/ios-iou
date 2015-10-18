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
    
    var groups:[Group] = []
    var maxGroupItems = 0
    var activity:UIActivityIndicatorView!
    var delegate:UIViewController!
    var activeUser:ActiveUser!
    
    
    init(activeUser:ActiveUser){
        super.init(nibName: nil, bundle: nil)
        self.activeUser = activeUser
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blueColor()
        self.tableView.registerClass(GroupCell.self, forCellReuseIdentifier: "groupCell")
        
        activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        view.addSubview(activity)
        activity.bringSubviewToFront(view)
        
//        GroupHandler().getGroupsForUser().onSuccess { groups in
//            self.groups = groups
//            self.tableView.reloadData()
//            self.activity.stopAnimating()
//            }
        self.activity.startAnimating()
        
    }
    
    func didFinishGroup(controller: GroupListPanel) {
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "groupCell"
        
        let cell:GroupCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroupCell
        cell.group = self.groups[indexPath.item]
        cell.groupName.text = groups[indexPath.item].description
        cell.memberCount.text = String(groups[indexPath.item].members.count)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:GroupCell = tableView.cellForRowAtIndexPath(indexPath) as! GroupCell
        let vc = GroupViewController(group: cell.group)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Find max size
        return self.groups.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
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