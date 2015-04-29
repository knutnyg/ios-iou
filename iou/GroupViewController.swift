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



class GroupView : UIViewController {
    
    var summaryView:SummaryViewController!
    var datepickerView:DatePickerViewController!
    var expensesTableView:ExpensesTableViewController!
    var tableHeader:TableViewHeader!
    var delegate:GroupListTableViewController!=nil
    var groupId:Int!
    

    
    override func viewDidLoad(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "backButtonPressed:", name: "backPressed", object: nil)

        summaryView = SummaryViewController()
        summaryView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        datepickerView = DatePickerViewController()
        datepickerView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        tableHeader = TableViewHeader()
        tableHeader.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        expensesTableView = ExpensesTableViewController(groupId: self.groupId)
        expensesTableView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.addChildViewController(summaryView)
        self.addChildViewController(datepickerView)
        self.addChildViewController(tableHeader)
        self.addChildViewController(expensesTableView)
        
        view.addSubview(summaryView.view)
        view.addSubview(datepickerView.view)
        view.addSubview(tableHeader.view)
        view.addSubview(expensesTableView.view)
        
        let views:[NSObject : AnyObject] = ["summary":summaryView.view,"datepicker":datepickerView.view, "expenses":expensesTableView.view, "tableHeader":tableHeader.view]
        
        setChildviewConstraints(views)
    }
    
    func setChildviewConstraints(views:[NSObject:AnyObject]){
        let screenHeight = view.frame.height
        println(screenHeight)
        
        switch screenHeight {
            //            case 480: setupForiPhoneFour(views)
            //            case 568: setupForiPhoneFive(views)
        case 667: setupForiPhoneSix(views)
        case 736: setupForiPhoneSix(views)
            //            case 1024: setupForiPadTwo(views)
        default: println("default")
        }
        
        
    }
    func setupForiPhoneSix(views:[NSObject:AnyObject]) {
        let constraintModel = GroupPanelConstraints(bannerHeight: 80, summaryHeight: 200, datepickerHeight: 50, expensesHeight: 300, cellHeight: 30)
        
        setConstraints(views, constraintsModel: constraintModel)
        
    }
    
    func setConstraints(views:[NSObject:AnyObject], constraintsModel:GroupPanelConstraints){
        
        var visualFormat = String(format: "V:|-72-[summary(%d)]-0-[datepicker(%d)]-[tableHeader(30)]-[expenses(%d)]",
            constraintsModel.summaryHeight,
            constraintsModel.datepickerHeight,
            constraintsModel.expensesHeight
        )
        
        
        
        let verticalLayout = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
      
        visualFormat = "H:|-0-[summary]-0-|"
        let profileWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        
        visualFormat = "H:|-0-[datepicker]-0-|"
        let groupPanelWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        
        visualFormat = "H:|-0-[expenses]-0-|"
        let buttonWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[tableHeader]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        view.addConstraints(verticalLayout)
        view.addConstraints(profileWidth)
        view.addConstraints(groupPanelWidth)
        view.addConstraints(buttonWidth)
    }
    
    func backButtonPressed(notification: NSNotification){
        //Got back
        println("got back")
        delegate.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    //----- Required initializers -----//
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(groupId:Int){
        self.groupId = groupId
        super.init(nibName: nil, bundle: nil)
    }
    
    
}

