
import Foundation
import UIKit


class AddParticipantsToExpenseTableViewController: UITableViewController {
    
    var delegate:UIViewController!
    var selectedMembers:[User] = []
    var expense:Expense!
    var group:Group!
    
    override func viewDidLoad() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.whiteColor()
        selectedMembers = expense.participants
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let profileImage = UIImage(named: "profile.png")!

        let rect = CGRectMake(0, 0, 40, 40)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 40,height: 40), false, 1.0)
        profileImage.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        cell.imageView?.image = newImage
        cell.textLabel?.text = group.members[indexPath.item].name


        do {
            if try expense.participants.map({return $0.id}).contains(group.members[indexPath.item].id) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        } catch {
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
        return group.members.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if let index = findUserInList(group.members[indexPath.item]) {
            selectedMembers.removeAtIndex(index)
            cell?.accessoryType = UITableViewCellAccessoryType.None
            
        } else {
            selectedMembers.append(group.members[indexPath.item])
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
    }
}