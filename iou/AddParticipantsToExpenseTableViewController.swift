
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

        let profileImage = UIImage(named: "profile.png")!

        let rect = CGRectMake(0, 0, 40, 40)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 40,height: 40), false, 1.0)
        profileImage.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

//        var profileImageView = UIImageView(image: newImage)
//        profileImageView.layer.borderWidth = 1.0
//        profileImageView.layer.masksToBounds = false
//        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
//        profileImageView.layer.cornerRadius = 100/2
//        profileImageView.clipsToBounds = true

        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        cell.imageView?.image = newImage
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
        return 75
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