
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
    var components:[UIView]!

    var group:Group!
    
    override func viewDidLoad(){

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "GroupMembershipChanged:", name:"GroupMembershipChanged", object:nil)
        
        setupNavigationBar()
        view.backgroundColor = UIColor.whiteColor()

        summaryHeaderView = SummaryHeaderView()
        
        summaryView = SummaryTableViewController()
        summaryView.delegate = self
                
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

        components = [summaryHeaderView.view, summaryView.view, addExpenseButton, addMemberButton, expensesTableView.view]

        var summaryHeight = min(group.members.count * 50, 250)

        let rules = [
                ConstraintRules() // Summary header
                .withMarginTop(72)
                .withHeight(30)
                .withSnapTop(view.snp_top)
                .withSnapLeft(view.snp_left)
                .withSnapRight(view.snp_right),
                ConstraintRules() // Summary
                .withHeight(summaryHeight)
                .withSnapTop(summaryHeaderView.view.snp_bottom)
                .withSnapLeft(view.snp_left)
                .withSnapRight(view.snp_right),
                ConstraintRules() // Expense button
                .withHeight(38)
                .withSnapTop(summaryView.view.snp_bottom)
                .withSnapLeft(view.snp_left)
                .withMarginLeft(8),
                ConstraintRules() // Add member button
                .withHeight(38)
                .withSnapTop(summaryView.view.snp_bottom)
                .withSnapRight(view.snp_right)
                .withMarginRight(8),
                ConstraintRules() // Expense table
                .withSnapTop(addExpenseButton.snp_bottom)
                .withSnapBottom(view.snp_bottom)
                .withSnapLeft(view.snp_left)
                .withSnapRight(view.snp_right)
        ]

        SnapKitHelpers.setConstraints(view, components: components, rules: rules)
    }

    func GroupMembershipChanged(notification:NSNotification){
        updateVerticalConstraints()
    }

    func updateVerticalConstraints() {
        var summaryHeight = min(group.members.count * 50, 250)

        let rules = [
                ConstraintRules() // Summary header
                .withMarginTop(72)
                .withHeight(30)
                .withSnapTop(view.snp_top)
                .withSnapLeft(view.snp_left)
                .withSnapRight(view.snp_right),
                ConstraintRules() // Summary
                .withHeight(summaryHeight)
                .withSnapTop(summaryHeaderView.view.snp_bottom)
                .withSnapLeft(view.snp_left)
                .withSnapRight(view.snp_right),
                ConstraintRules() // Expense button
                .withHeight(38)
                .withSnapTop(summaryView.view.snp_bottom)
                .withSnapLeft(view.snp_left)
                .withMarginLeft(8),
                ConstraintRules() // Add member button
                .withHeight(38)
                .withSnapTop(summaryView.view.snp_bottom)
                .withSnapRight(view.snp_right)
                .withMarginRight(8),
                ConstraintRules() // Expense table
                .withSnapTop(addExpenseButton.snp_bottom)
                .withSnapBottom(view.snp_bottom)
                .withSnapLeft(view.snp_left)
                .withSnapRight(view.snp_right)
        ]

        SnapKitHelpers.updateConstraints(view, components: components, rules: rules)
        super.updateViewConstraints()
    }

    func refreshData(){
        API.getAllGroupData(group).onSuccess {
            group in
            self.group = group
            self.summaryView.tableView.reloadData()
            self.expensesTableView.tableView.reloadData()
        }
    }

    override func viewDidAppear(animated: Bool) {
        //reload expenses
        refreshData()
    }
    
    func setupNavigationBar(){
        navigationItem.title = group.description
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }

    func newExpensePressed(sender:UIButton) {
        print("create new expense")
        let vc = NewExpense()
        vc.delegate = self
        vc.groupMembers = group.members
        navigationController?.pushViewController(vc, animated: true)
    }

    func newMemberPressed(sender:UIButton) {
        print("create new member")
        let vc = EditGroup()
        vc.delegate = self

        navigationController?.pushViewController(vc, animated: true)
    }
}

