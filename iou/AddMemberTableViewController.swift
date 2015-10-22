//
//  MemberTableView.swift
//  iou
//
//  Created by Knut Nygaard on 20/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit


class AddMemberTableViewController : UITableViewController {
    
    var delegate:EditGroup!
    
    override func viewDidLoad() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.whiteColor()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = delegate.searchResult[indexPath.item].name
        return cell
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Find max size
        return delegate.searchResult.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        delegate.group.members.append(delegate.searchResult[indexPath.item])
        
        API.putGroup(delegate.group)
            .onSuccess{group in
                self.delegate.navigationController?.popViewControllerAnimated(true)
            }
            .onFailure{ err in
                self.delegate.group.members.removeLast()
            }
    }
}