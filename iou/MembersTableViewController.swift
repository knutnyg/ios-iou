//
//  MemberTableView.swift
//  iou
//
//  Created by Knut Nygaard on 20/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit


class MembersTableViewController : UITableViewController {
    
    var delegate:EditExpense!
    
    override func viewDidLoad() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.whiteColor()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = delegate.group.members[indexPath.item].name
        return cell
        
    }
    
    func findUserInList(user:User) -> Int?{
        var i = 0
        for u in delegate.selectedMembers {
            if u.id == user.id {
                return i
            }
            i += 1
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Find max size
        return delegate.group.members.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if let index = findUserInList(delegate.group.members[indexPath.item]) {
            delegate.selectedMembers.removeAtIndex(index)
            cell?.accessoryType = UITableViewCellAccessoryType.None
            
        } else {
            delegate.selectedMembers.append(delegate.group.members[indexPath.item])
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
    }
}