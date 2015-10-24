
import Foundation
import UIKit


class AddParticipantsToExpenseTableViewController: UITableViewController {
    
    var delegate:UIViewController!
    var selectedMembers:[User] = []
    
    override func viewDidLoad() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.whiteColor()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = API.currentGroup!.members[indexPath.item].name

        if let exp = API.currentExpense {
            if exp.participants.map({return $0.id}).contains(API.currentGroup!.members[indexPath.item].id){
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }

        return cell
        
    }
    
    func findUserInList(user:User) -> Int?{
        var i = 0
        for u in selectedMembers {
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
        return API.currentGroup!.members.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if let index = findUserInList(API.currentGroup!.members[indexPath.item]) {
            selectedMembers.removeAtIndex(index)
            cell?.accessoryType = UITableViewCellAccessoryType.None
            
        } else {
            selectedMembers.append(API.currentGroup!.members[indexPath.item])
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
    }
}