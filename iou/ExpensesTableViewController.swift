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
    
    var expenses:[Expense]!
    var activity:UIActivityIndicatorView!
    var groupId:Int!
    var delegate:GroupListTableViewController!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.greenColor()
        self.activity = UIActivityIndicatorView()
        self.expenses = []
        
        ExpensesHandler().getExpensesForGroup(self.groupId).onSuccess{expenseList in
            self.expenses = expenseList
            self.tableView.reloadData()
            self.activity.stopAnimating()
        }
        self.activity.startAnimating()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = "test: \(indexPath.item)"
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.expenses.count
    }
    
    override func viewDidLayoutSubviews() {
        positionSpinnerInMiddle()
    }
    
    func positionSpinnerInMiddle(){
        var x = view.bounds.width / 2
        var y = view.bounds.height / 2
        activity.center = CGPoint(x: x, y: y)
    }
    
    //----- Required initializers -----//
    
    init(groupId:Int) {
        super.init()
        self.groupId = groupId
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