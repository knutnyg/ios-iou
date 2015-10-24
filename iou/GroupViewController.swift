
import Foundation
import UIKit

class GroupViewController : UIViewController {
    
    var summaryHeaderView:SummaryHeaderView!
    var summaryView:SummaryTableViewController!
    var expensesTableView:ExpensesTableViewController!
    var tableHeader:TableViewHeader!
    var delegate:UIViewController?
    var addExpenseButton:UIButton!
    var addMemberButton:UIButton!
    
    override func viewDidLoad(){
        
        setupNavigationBar()
        view.backgroundColor = UIColor.whiteColor()

        summaryHeaderView = SummaryHeaderView()
        summaryHeaderView.view.translatesAutoresizingMaskIntoConstraints = false
        
        summaryView = SummaryTableViewController()
        summaryView.delegate = self
        summaryView.view.translatesAutoresizingMaskIntoConstraints = false
                
        addExpenseButton = createButton("+ exp")
        addExpenseButton.addTarget(self, action: Selector("newExpensePressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        addMemberButton = createButton("+ member")
        addMemberButton.addTarget(self, action: Selector("newMemberPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        tableHeader = TableViewHeader()
        tableHeader.view.translatesAutoresizingMaskIntoConstraints = false
        
        expensesTableView = ExpensesTableViewController()
        expensesTableView.delegate = self
        expensesTableView.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChildViewController(summaryHeaderView)
        addChildViewController(summaryView)
        addChildViewController(tableHeader)
        addChildViewController(expensesTableView)
        
        view.addSubview(summaryHeaderView.view)
        view.addSubview(summaryView.view)
        view.addSubview(tableHeader.view)
        view.addSubview(addExpenseButton)
        view.addSubview(addMemberButton)
        view.addSubview(expensesTableView.view)
        
        let views:[String : AnyObject] = ["summaryHeader":summaryHeaderView.view,"summary":summaryView.view, "expenses":expensesTableView.view, "tableHeader":tableHeader.view, "addButton":addExpenseButton, "addMember":addMemberButton]
        
        var summaryHeight = API.currentGroup!.members.count * 30
        if summaryHeight > 180 {
            summaryHeight = 180
        }
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-63-[summaryHeader(30)]-0-[summary(\(summaryHeight))]-0-[addButton]-[tableHeader(30)]-[expenses]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: addExpenseButton, attribute: .CenterY, relatedBy: .Equal, toItem: addMemberButton, attribute: .CenterY, multiplier: 1, constant: 0))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[summaryHeader]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[summary]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[addButton(100)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[addMember(100)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableHeader]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[expenses]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    override func viewDidAppear(animated: Bool) {
        //reload expenses
        API.currentExpense = nil
        API.getAllGroupData(API.currentGroup!).onSuccess {
            group in
            API.currentGroup = group
            self.summaryView.tableView.reloadData()
            self.expensesTableView.tableView.reloadData()
        }
    }
    
    func setupNavigationBar(){
        navigationItem.title = API.currentGroup!.description
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }



    func newExpensePressed(sender:UIButton) {
        print("create new expense")
        let vc = NewExpense()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func newMemberPressed(sender:UIButton) {
        print("create new member")
        let vc = EditGroup()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)

    }
}

