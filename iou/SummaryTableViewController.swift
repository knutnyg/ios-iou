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

    var delegate:GroupViewController!
    
    override func viewDidLoad() {
        self.tableView.registerClass(SummaryTableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:SummaryTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SummaryTableViewCell
        let user = API.currentGroup!.members[indexPath.item]
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
        return API.currentGroup!.members.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func getTotalPaid(user:User) -> Double {
        var paid:Double = 0
        for expense in API.currentGroup!.expenses {
            if expense.creator.id == user.id {
                paid += expense.amount
            }
        }

        return paid
    }
    
    func getTotalOwed(user:User) -> Double {

        var owed:Double = 0
        for expense:Expense in API.currentGroup!.expenses {
            if expense.participants.map({ return $0.id }).contains(user.id) {
                owed += (expense.amount / Double(API.currentGroup!.members.count))
            }
        }
        return owed
    }
    
    func getSum(user:User) -> Double {
        return 0.0
    }
}
    