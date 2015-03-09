//
//  GroupPanelViewController.swift
//  iou
//
//  Created by Knut Nygaard on 3/5/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class GroupPanelViewController : UITableViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blueColor()
        
        self.tableView.registerClass(GroupCell.self, forCellReuseIdentifier: "groupCell")
    }

    let groups:[String] = ["gruppe1", "gruppe2", "gruppe3", "gruppe3", "gruppe3", "gruppe3", "gruppe3", "gruppe3", "gruppe3"]
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellIdentifier:String = "groupCell"
        
        var cell:GroupCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as GroupCell
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Handle press on group
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Find max size
        return groups.count
        
    }
    
    

    
    
}
