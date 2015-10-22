
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
    
    override func viewDidLoad(){
        
        setupNavigationBar()
        view.backgroundColor = UIColor.whiteColor()

        summaryHeaderView = SummaryHeaderView()
        summaryHeaderView.view.translatesAutoresizingMaskIntoConstraints = false
        
        summaryView = SummaryTableViewController(group: group)
        summaryView.view.translatesAutoresizingMaskIntoConstraints = false
                
        addExpenseButton = createNewButton()
        addExpenseButton.addTarget(self, action: Selector("newButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        tableHeader = TableViewHeader()
        tableHeader.view.translatesAutoresizingMaskIntoConstraints = false
        
        expensesTableView = ExpensesTableViewController(group: group)
        expensesTableView.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChildViewController(summaryHeaderView)
        addChildViewController(summaryView)
        addChildViewController(tableHeader)
        addChildViewController(expensesTableView)
        
        view.addSubview(summaryHeaderView.view)
        view.addSubview(summaryView.view)
        view.addSubview(tableHeader.view)
        view.addSubview(addExpenseButton)
        view.addSubview(expensesTableView.view)
        
        let views:[String : AnyObject] = ["summaryHeader":summaryHeaderView.view,"summary":summaryView.view, "expenses":expensesTableView.view, "tableHeader":tableHeader.view, "addButton":addExpenseButton]
        
        var summaryHeight = group.members.count * 30
        if summaryHeight > 180 {
            summaryHeight = 180
        }
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-63-[summaryHeader(30)]-0-[summary(\(summaryHeight))]-0-[addButton(50)]-[tableHeader(30)]-[expenses]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[summaryHeader]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[summary]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: addExpenseButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableHeader]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[expenses]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    override func viewDidAppear(animated: Bool) {
        //reload expenses
        API.getAllGroupData(group).onSuccess { group in
            self.expensesTableView.group = group
            self.expensesTableView.tableView.reloadData()
        }
        //force load table
    }
    
    func createNewButton() -> UIButton{
        let button = UIButton(type: UIButtonType.System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+ new", forState: .Normal)
        button.titleLabel!.font = UIFont(name:"Helvetica", size:30)
        return button
    }
    
    func setupNavigationBar(){
        navigationItem.title = group.description
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
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
    
    func newButtonPressed(sender:UIButton) {
        print("create new expense")
        let vc = EditExpense(group: group)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

