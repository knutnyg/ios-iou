
import Foundation
import UIKit

class GroupViewController : UIViewController {
    
    var summaryHeaderView:SummaryHeaderView!
    var summaryView:SummaryTableViewController!
    var expensesTableView:ExpensesTableViewController!
    var delegate:UIViewController?
    var addExpenseButton:UIButton!
    var addMemberButton:UIButton!

    var verticalConstraints:[NSLayoutConstraint]?
    var views:[String:AnyObject]!
    
    override func viewDidLoad(){

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "GroupMembershipChanged:", name:"GroupMembershipChanged", object:nil)
        
        setupNavigationBar()
        view.backgroundColor = UIColor.whiteColor()

        summaryHeaderView = SummaryHeaderView()
        summaryHeaderView.view.translatesAutoresizingMaskIntoConstraints = false
        
        summaryView = SummaryTableViewController()
        summaryView.delegate = self
        summaryView.view.translatesAutoresizingMaskIntoConstraints = false
                
        addExpenseButton = createButton("+Expense", font: UIFont(name: "HelveticaNeue",size: 24)!)

        addExpenseButton.addTarget(self, action: Selector("newExpensePressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        addMemberButton = createButton("+Member", font: UIFont(name: "HelveticaNeue",size: 24)!)
        addMemberButton.addTarget(self, action: Selector("newMemberPressed:"), forControlEvents: UIControlEvents.TouchUpInside)

        expensesTableView = ExpensesTableViewController()
        expensesTableView.delegate = self
        expensesTableView.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChildViewController(summaryHeaderView)
        addChildViewController(summaryView)
        addChildViewController(expensesTableView)
        
        view.addSubview(summaryHeaderView.view)
        view.addSubview(summaryView.view)
        view.addSubview(addExpenseButton)
        view.addSubview(addMemberButton)
        view.addSubview(expensesTableView.view)
        
        views = ["summaryHeader":summaryHeaderView.view,"summary":summaryView.view, "expenses":expensesTableView.view, "addButton":addExpenseButton, "addMember":addMemberButton]

        recalculateVerticalConstraint()

        view.addConstraint(NSLayoutConstraint(item: addExpenseButton, attribute: .CenterY, relatedBy: .Equal, toItem: addMemberButton, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: addExpenseButton, attribute: .Height, relatedBy: .Equal, toItem: addMemberButton, attribute: .Height, multiplier: 1, constant: 0))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[summaryHeader]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[summary]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[addButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[addMember]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[expenses]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }

    func GroupMembershipChanged(notification:NSNotification){
        recalculateVerticalConstraint()
    }

    func recalculateVerticalConstraint() {
        if verticalConstraints != nil {
            view.removeConstraints(verticalConstraints!)
        }

        var summaryHeight = API.currentGroup!.members.count * 50
        if summaryHeight > 250 {
            summaryHeight = 250
        }
        verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-72-[summaryHeader(30)]-0-[summary(\(summaryHeight))]-[addButton(38)]-[expenses]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        view.addConstraints(verticalConstraints!)

    }

    func refreshData(){
        API.getAllGroupData(API.currentGroup!).onSuccess {
            group in
            API.currentGroup = group
            self.summaryView.tableView.reloadData()
            self.expensesTableView.tableView.reloadData()
        }
    }

    override func viewDidAppear(animated: Bool) {
        //reload expenses
        API.currentExpense = nil
        refreshData()
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

