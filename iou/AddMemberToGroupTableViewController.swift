
import Foundation
import UIKit


class AddMemberToGroupTableViewController : UITableViewController {

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
        return delegate.searchResult.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        delegate.group.members.append(delegate.searchResult[indexPath.item])
        
        API.putGroup(delegate.group)
            .onSuccess{group in
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name:"GroupMembershipChanged", object: nil))
                self.delegate.navigationController?.popViewControllerAnimated(true)
            }
            .onFailure{ err in
                self.delegate.group.members.removeLast()
            }
    }
}