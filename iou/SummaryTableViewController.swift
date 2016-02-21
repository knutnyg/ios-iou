import Foundation
import UIKit

class SummaryTableViewController: UITableViewController {

    var delegate: GroupViewController!

    func sortedMembers() -> [User] {
        return delegate.group.members.sort({ $0.name < $1.name })
    }

    override func viewDidLoad() {
        self.tableView.registerClass(SummaryTableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell: SummaryTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SummaryTableViewCell
        let user = sortedMembers()[indexPath.item]
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
        return sortedMembers().count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

    func getTotalPaid(user: User) -> Double {
        do {
            return try delegate.group.expenses
            .filter {
                expense in expense.creator.id == user.id
            }.reduce(0, combine: { $0 + $1.amount })
        } catch {
        }
    }

    func getTotalOwed(user: User) -> Double {
        do {
            return try delegate.group.expenses
            .filter {
                expense in expense.participants.map {
                    user in return user.id
                }.contains(user.id)
            }
            .reduce(0, combine: { $0 + ($1.amount / Double($1.participants.count)) })
        } catch {
        }
    }
}
    