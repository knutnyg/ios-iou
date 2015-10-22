//
//  ExpensesTableViewController.swift
//  iou
//
//  Created by Knut Nygaard on 3/11/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class ExpensesTableViewController:UITableViewController {
    
    var activity:UIActivityIndicatorView!
    var group:Group!
    var delegate:UIViewController!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.greenColor()
        self.activity = UIActivityIndicatorView()
        
        self.tableView.registerClass(ExpenseCell.self, forCellReuseIdentifier: "expenseCell")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "expenseCell"
        let cell:ExpenseCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExpenseCell
        cell.expense = group.expenses[indexPath.item]
        cell.updateLabels()

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:ExpenseCell = tableView.cellForRowAtIndexPath(indexPath) as! ExpenseCell
        let vc = ReceiptViewController(group: group, receipt: cell.expense)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.expenses.count
    }
    
    override func viewDidLayoutSubviews() {
        positionSpinnerInMiddle()
    }
    
    func positionSpinnerInMiddle(){
        let x = view.bounds.width / 2
        let y = view.bounds.height / 2
        activity.center = CGPoint(x: x, y: y)
    }
    
    //----- Required initializers -----//
    
    init(group:Group) {
        super.init(nibName: nil, bundle: nil)
        self.group = group
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
}