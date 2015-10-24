

import Foundation
import UIKit

class ExpensesTableViewController:UITableViewController {
    
    var activity:UIActivityIndicatorView!
    var delegate:GroupViewController!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.greenColor()
        self.activity = UIActivityIndicatorView()
        
        self.tableView.registerClass(ExpenseCell.self, forCellReuseIdentifier: "expenseCell")
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "expenseCell"
        let cell:ExpenseCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExpenseCell
        cell.expense = API.currentGroup!.expenses[indexPath.item]
        cell.updateLabels()

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:ExpenseCell = tableView.cellForRowAtIndexPath(indexPath) as! ExpenseCell
        API.currentExpense = API.currentGroup!.expenses[indexPath.item]

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
}