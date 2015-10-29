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
    var unArchivedGroups:[Group] = []
    var maxGroupItems = 0
    var delegate:MainViewController!

    var visibleGroups:[Group] = []

    let unarchiveButton = UITableViewRowAction(style: .Normal, title: "unArchive") { action, index in
        NSNotificationCenter.defaultCenter().postNotificationName("unArchive", object: index.item)
    }

    let archiveButton = UITableViewRowAction(style: .Default, title: "Archive") { action, index in
        NSNotificationCenter.defaultCenter().postNotificationName("archive", object: index.item)
    }


    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "archivePressed:", name: "archive", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "unArchivePressed:", name: "unArchive", object: nil)
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false

        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.purpleColor()
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)

        tableView.addSubview(refreshControl)
    }

    func archivePressed(notification: NSNotification) {
        guard let indexPath:Int = notification.object as? Int else {
            return
        }

        guard let idx = findGroupIndexById(groups, archivedGroup: visibleGroups[indexPath]) else {
            return
        }

        groups[idx].archived = true
        visibleGroups[indexPath].archived = true
        API.putGroup(visibleGroups[indexPath])
        .onSuccess{group in
            self.unArchivedGroups = self.groups.filter({$0.archived == false})
            self.visibleGroups = self.unArchivedGroups
            self.tableView.reloadData()
        }
        .onFailure {
            err in
            self.groups[idx].archived = false
            self.visibleGroups[indexPath].archived = false
        }
    }

    func unArchivePressed(notification: NSNotification) {
        guard let indexPath:Int = notification.object as? Int else {
            return
        }

        guard let idx = findGroupIndexById(groups, archivedGroup: visibleGroups[indexPath]) else {
            return
        }

        groups[idx].archived = false
        visibleGroups[indexPath].archived = false
        API.putGroup(visibleGroups[indexPath])
        .onSuccess{group in
            self.unArchivedGroups = self.groups.filter({$0.archived == false})
            self.tableView.reloadData()
        }
        .onFailure {
            err in
            self.groups[idx].archived = true
            self.visibleGroups[indexPath].archived = true
        }
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        API.getGroupsForUser().onSuccess { groups in
            self.groups = groups
            self.unArchivedGroups = groups.filter({$0.archived == false})
            if self.delegate.tableHeader.archived.on == true {
                self.visibleGroups = groups
            } else {
                self.visibleGroups = self.unArchivedGroups
            }
            self.tableView.reloadData()
        }
    }


    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Groups:"
//    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if visibleGroups[indexPath.item].archived == true {
            return [unarchiveButton]
        } else {
            return [archiveButton]
        }
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        print("test")

        guard let idx = findGroupIndexById(groups, archivedGroup: visibleGroups[indexPath.item]) else {
            return
        }

        if visibleGroups[indexPath.item].archived == true {

            groups[idx].archived = false
            visibleGroups[indexPath.item].archived = false
            API.putGroup(visibleGroups[indexPath.item])
            .onSuccess{group in
                self.visibleGroups = self.groups.filter({$0.archived == false})
                self.tableView.reloadData()
            }
            .onFailure{err in
                self.groups[idx].archived = true
                self.visibleGroups[indexPath.item].archived = true
            }
        } else {
            groups[idx].archived = true
            visibleGroups[indexPath.item].archived = true
            API.putGroup(visibleGroups[indexPath.item])
            .onSuccess{group in
                self.visibleGroups = self.groups.filter({$0.archived == false})
                self.tableView.reloadData()
            }
            .onFailure{err in
                self.groups[idx].archived = false
                self.visibleGroups[indexPath.item].archived = false
            }
        }
    }

    func refresh(refreshControl: UIRefreshControl){
        API.getGroupsForUser().onSuccess{groups in
            self.groups = groups
            refreshControl.endRefreshing()
        }

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "groupCell")
        cell.textLabel?.text = visibleGroups[indexPath.item].description
        cell.detailTextLabel?.text = "Last entry: 10h"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        API.currentGroup = visibleGroups[indexPath.item]
        let vc = GroupViewController()

        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Find max size
        return visibleGroups.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

    func findGroupIndexById(groupList:[Group], archivedGroup:Group) -> Int? {
        var i = 0
        for group in groupList {
            if group.id == archivedGroup.id {
                return i
            }
            i++
        }
        return nil

    }
}