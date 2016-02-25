
import Foundation
import UIKit

class GroupListTableViewController : UITableViewController {

    var delegate:MainViewController!
    var groups:[Group] = []
    var showArchived:Bool = false

    override func viewDidLoad() {

        view.backgroundColor = UIColor.whiteColor()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "archivedPressed:", name: "archiveAction", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "buttonChanged:", name: "buttonChanged", object: nil)

        let refreshSpinner = createRefreshController()
        refreshSpinner.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)

        tableView.addSubview(refreshSpinner)
    }

    func archivedPressed(notification: NSNotification){
        guard let group:Group = notification.object as? Group else {
            return
        }
        group.archived = !group.archived

        API.putGroup(group)
        .onSuccess{group in
            if(self.showArchived) {
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "setArchiveButtonValue",object:false))
            }
            self.reloadUI()
        }
        .onFailure {
            err in
            group.archived = !group.archived
        }
    }

    func reloadUI(){
        API.getGroupsForUser().onSuccess { groups in
            self.groups = groups
            self.tableView.reloadData()
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
        return self.groups
            .filter{group in return !group.archived || self.showArchived}
            .sort({$0.lastUpdated.compare($1.lastUpdated) == NSComparisonResult.OrderedDescending})
    }

    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let archiveButton = UITableViewRowAction(style: .Normal, title: "archive") { action, index in
            NSNotificationCenter.defaultCenter().postNotificationName("archiveAction", object: self.visibleGroups()[index.item])
        }

        let unarchiveButton = UITableViewRowAction(style: .Normal, title: "unArchive") { action, index in
            NSNotificationCenter.defaultCenter().postNotificationName("archiveAction", object: self.visibleGroups()[index.item])
        }

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
            self.reloadUI()
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

        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "groupCell")
        cell.textLabel?.text = group.description
        cell.detailTextLabel?.text = "Last entry: \(group.lastUpdated.relativePrintable())"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = GroupViewController()
        vc.group = visibleGroups()[indexPath.item]

        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
