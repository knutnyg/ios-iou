
import Foundation
import UIKit

class GroupViewController : UIViewController {
    
    var summaryHeaderView:SummaryHeaderView!
    var summaryView:SummaryTableViewController!
    var expensesTableView:ExpensesTableViewController!
    var tableHeader:TableViewHeader!
    var delegate:UIViewController?
    var group:Group!
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
        
        var summaryHeight = group.members.count * 30
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
        API.getAllGroupData(group).onSuccess {
            group in
            self.group = group

            self.group.expenses = self.group.expenses.sort({$0.date.timeIntervalSinceNow > $1.date.timeIntervalSinceNow})

            self.summaryView.tableView.reloadData()
            self.expensesTableView.tableView.reloadData()
        }
    }
    
    func setupNavigationBar(){
        navigationItem.title = group.description
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }



    func newExpensePressed(sender:UIButton) {
        print("create new expense")
        let vc = EditExpense(group: group)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func newMemberPressed(sender:UIButton) {
        print("create new member")
        let vc = EditGroup(group: group)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)

    }

    //----- Required initializers -----//

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(group:Group){
        self.group = group
        super.init(nibName: nil, bundle: nil)
    }

}

