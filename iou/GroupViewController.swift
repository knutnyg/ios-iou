//
//  GroupViewParent.swift
//  iou
//
//  Created by Knut Nygaard on 3/11/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

//
//  parentViewController.swift
//  iou
//
//  Created by Knut Nygaard on 3/5/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit



class GroupViewController : UIViewController {
    
    var summaryView:SummaryViewController!
    var datepickerView:DatePickerViewController!
    var expensesTableView:ExpensesTableViewController!
    var tableHeader:TableViewHeader!
    var delegate:UIViewController?
    var group:Group!
    var addExpenseButton:UIButton!
    
    override func viewDidLoad(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "backButtonPressed:", name: "backPressed", object: nil)

        summaryView = SummaryViewController()
        summaryView.view.translatesAutoresizingMaskIntoConstraints = false
        
//        datepickerView = DatePickerViewController()
//        datepickerView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        addExpenseButton = createNewButton()
        addExpenseButton.addTarget(self, action: Selector("newButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        tableHeader = TableViewHeader()
        tableHeader.view.translatesAutoresizingMaskIntoConstraints = false
        
//        expensesTableView = ExpensesTableViewController(group: self.group)
//        expensesTableView.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChildViewController(summaryView)
        self.addChildViewController(tableHeader)
//        self.addChildViewController(expensesTableView)
        
        view.addSubview(summaryView.view)
        view.addSubview(tableHeader.view)
        view.addSubview(addExpenseButton)
//        view.addSubview(expensesTableView.view)
        
        let views:[String : AnyObject] = ["summary":summaryView.view, "expenses":expensesTableView.view, "tableHeader":tableHeader.view, "addButton":addExpenseButton]
        
        setConstraints(views)
    }
    
    func setConstraints(views:[String:AnyObject]){
        
        var visualFormat = String(format: "V:|-72-[summary(250)]-0-[addButton(50)]-[tableHeader(30)]-[expenses]-|")
        
        let verticalLayout = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
      
        visualFormat = "H:|-0-[summary]-0-|"
        let profileWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        visualFormat = "H:|-0-[expenses]-0-|"
        let buttonWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[tableHeader]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        view.addConstraints(verticalLayout)
        view.addConstraints(profileWidth)
        view.addConstraints(buttonWidth)
    }
    
    func backButtonPressed(notification: NSNotification){
        delegate!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createNewButton() -> UIButton{
        let button = UIButton(type: UIButtonType.System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", forState: .Normal)
        button.titleLabel!.font = UIFont(name:"Helvetica", size:30)
        return button
    }
    
    func sendButtonPressed(sender:UIButton!){
        //TODO display progress and verified completion
        
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
    }
    
    
}

