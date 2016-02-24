
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

        let verticalRules = [
                VerticalConstraintRules().withMarginTop(72).withHeight(30).withSnapTop(view.snp_top),
                VerticalConstraintRules().withHeight(summaryHeight).withSnapTop(summaryHeaderView.view.snp_bottom),
                VerticalConstraintRules().withHeight(38).withSnapTop(summaryView.view.snp_bottom),
                VerticalConstraintRules().withHeight(38).withSnapTop(summaryView.view.snp_bottom),
                VerticalConstraintRules().withSnapTop(addExpenseButton.snp_bottom).withSnapBottom(view.snp_bottom),
        ]
        let horizontalRules = [
                HorizontalConstraintRules().withSnapLeft(view.snp_left).withSnapRight(view.snp_right),
                HorizontalConstraintRules().withSnapLeft(view.snp_left).withSnapRight(view.snp_right),
                HorizontalConstraintRules().withSnapLeft(view.snp_left).withMarginLeft(8),
                HorizontalConstraintRules().withSnapRight(view.snp_right).withMarginRight(8),
                HorizontalConstraintRules().withSnapLeft(view.snp_left).withSnapRight(view.snp_right)
        ]

        SnapKitHelpers.setVerticalConstraints(view, components: components, rules: verticalRules)
        SnapKitHelpers.setHorizontalConstraints(view, components: components, rules: horizontalRules)
    }

    func GroupMembershipChanged(notification:NSNotification){
        updateVerticalConstraints()
    }

    func updateVerticalConstraints() {
        var summaryHeight = min(group.members.count * 50, 250)

        let verticalRules = [
                VerticalConstraintRules().withMarginTop(72).withHeight(30).withSnapTop(view.snp_top),
                VerticalConstraintRules().withHeight(summaryHeight).withSnapTop(summaryHeaderView.view.snp_bottom),
                VerticalConstraintRules().withHeight(38).withSnapTop(summaryView.view.snp_bottom),
                VerticalConstraintRules().withHeight(38).withSnapTop(summaryView.view.snp_bottom),
                VerticalConstraintRules().withSnapTop(addExpenseButton.snp_bottom).withSnapBottom(view.snp_bottom),
        ]

        SnapKitHelpers.updateVerticalConstraints(view, components: components, rules: verticalRules)
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

