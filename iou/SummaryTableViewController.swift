//
//  SummaryViewController.swift
//  iou
//
//  Created by Knut Nygaard on 04/04/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class SummaryTableViewController:UITableViewController {
    
    var group:Group!
    
    override func viewDidLoad() {
        self.tableView.registerClass(SummaryTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:SummaryTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SummaryTableViewCell
        let user = group.members[indexPath.item]
        if let sn = user.shortName {
            cell.updateLabels(sn, paid: getTotalPaid(user), owes: getTotalOwed(user))
        } else {
            cell.updateLabels(user.name, paid: getTotalPaid(user), owes: getTotalOwed(user))
        }
        return cell
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Find max size
        return group.members.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func getTotalPaid(user:User) -> Double {
        return 0.0
    }
    
    func getTotalOwed(user:User) -> Double {
        return 0.0
    }
    
    func getSum(user:User) -> Double {
        return 0.0
    }
    
    /* ----   Initializers   ----  */
    
    init(group:Group) {
        super.init(nibName: nil, bundle: nil)
        self.group = group
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Here you can init your properties
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


}
    