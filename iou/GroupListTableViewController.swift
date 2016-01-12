
import Foundation
import UIKit

class GroupListTableViewController : UITableViewController {
    
    var groups:[Group] = []
    var unArchivedGroups:[Group] = []
    var maxGroupItems = 0
    var delegate:MainViewController!
    var showArchived:Bool = false

    let unarchiveButton = UITableViewRowAction(style: .Normal, title: "unArchive") { action, index in
        NSNotificationCenter.defaultCenter().postNotificationName("unArchive", object: index.item)
    }

    let archiveButton = UITableViewRowAction(style: .Default, title: "Archive") { action, index in
        NSNotificationCenter.defaultCenter().postNotificationName("archive", object: index.item)
    }

    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "archivePressed:", name: "archive", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "unArchivePressed:", name: "unArchive", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "buttonChanged:", name: "buttonChanged", object: nil)
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

        visibleGroups()[indexPath].archived = true

        API.putGroup(groups[indexPath])
        .onSuccess{group in
            self.tableView.reloadData()
        }
        .onFailure {
            err in
            self.visibleGroups()[indexPath].archived = false
        }
    }

    func unArchivePressed(notification: NSNotification) {
        guard let indexPath:Int = notification.object as? Int else {
            return
        }

        visibleGroups()[indexPath].archived = false

        API.putGroup(visibleGroups()[indexPath])
        .onSuccess{group in
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "setArchiveButtonValue",object:false))
        }
        .onFailure {
            err in
            self.visibleGroups()[indexPath].archived = true
        }
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        API.getGroupsForUser().onSuccess { groups in
            self.groups = groups
            self.tableView.reloadData()
        }
    }

    func visibleGroups() -> [Group]{
        return self.groups.filter{group in return !group.archived || self.showArchived}
    }

    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if visibleGroups()[indexPath.item].archived == true {
            return [unarchiveButton]
        } else {
            return [archiveButton]
        }
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        var archivedStatus = visibleGroups()[indexPath.item].archived

        visibleGroups()[indexPath.item].archived = !archivedStatus
        API.putGroup(visibleGroups()[indexPath.item])
        .onSuccess {
            group in
            self.tableView.reloadData()
        }
        .onFailure {
            err in
            self.visibleGroups()[indexPath.item].archived = archivedStatus
        }
    }

    func refresh(refreshControl: UIRefreshControl){
        API.getGroupsForUser().onSuccess{groups in
            self.groups = groups
            refreshControl.endRefreshing()
        }

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let group = visibleGroups()[indexPath.item]
//        let group = visibleGroups[indexPath.item]

        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "groupCell")
        cell.textLabel?.text = group.description
        cell.detailTextLabel?.text = "Last entry: \(group.lastUpdated.relativePrintable())"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        API.currentGroup = visibleGroups()[indexPath.item]
        let vc = GroupViewController()

        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Find max size
        return visibleGroups().count
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

    func buttonChanged(notification: NSNotification){
        showArchived = notification.object as! Bool
        tableView.reloadData()
    }
}
