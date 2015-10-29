

import Foundation
import UIKit

class ExpensesTableViewController:UITableViewController {
    
    var activity:UIActivityIndicatorView!
    var delegate:GroupViewController!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.activity = UIActivityIndicatorView()

        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.purpleColor()
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)

        tableView.addSubview(refreshControl)
        
        self.tableView.registerClass(ExpenseCell.self, forCellReuseIdentifier: "expenseCell")
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "expenseCell"
        let cell:ExpenseCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExpenseCell
        cell.expense = API.currentGroup!.expenses[indexPath.item]
        cell.updateLabels()

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //
            let expense = API.currentGroup!.expenses[indexPath.item]
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
        API.currentExpense = API.currentGroup!.expenses[indexPath.item]

        print("in did select")

        let vc = EditExpense()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return API.currentGroup!.expenses.count
    }
    
    override func viewDidLayoutSubviews() {
        positionSpinnerInMiddle()
    }
    
    func positionSpinnerInMiddle() {
        let x = view.bounds.width / 2
        let y = view.bounds.height / 2
        activity.center = CGPoint(x: x, y: y)
    }

    func refresh(refreshControl: UIRefreshControl){
        API.getAllGroupData(API.currentGroup!).onSuccess{group in
            API.currentGroup = group
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }

    }
}