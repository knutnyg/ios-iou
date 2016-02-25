
import Foundation
import UIKit

class ExpensesTableViewController:UITableViewController {
    
    var activity:UIActivityIndicatorView!
    var delegate:GroupViewController!
    var refreshSpinner:UIRefreshControl!

    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()

        refreshSpinner = createRefreshController()
        refreshSpinner.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)

        tableView.addSubview(refreshSpinner)
        
        self.tableView.registerClass(ExpenseCell.self, forCellReuseIdentifier: "expenseCell")
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "expenseCell"
        let cell:ExpenseCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExpenseCell
        cell.expense = sortedExpenses()[indexPath.item]
        cell.updateLabels()

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let expense = sortedExpenses()[indexPath.item]
            API.deleteExpense(expense).onSuccess{expense in
                self.delegate.refreshData()
            }
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Expense list:"
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = EditExpense()
        vc.delegate = self.delegate
        vc.expense = sortedExpenses()[indexPath.item].copy()
        vc.groupMembers = sortedMembers()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedExpenses().count
    }

    func refresh(refreshControl: UIRefreshControl){
        delegate.refreshData()

    }

    func sortedMembers() -> [User]{
        if let group = delegate.group {
            return group.members.sort({ $0.name < $1.name })
        } else {
            return []
        }
    }

    func sortedExpenses() -> [Expense] {
        if let group = delegate.group {
            return group.expenses.sort({
                if let d1 = $0.date, d2 = $1.date {
                    return d1.timeIntervalSinceNow > d2.timeIntervalSinceNow
                } else {
                    return false
                }
            })
        } else {
            return []
        }
    }
}