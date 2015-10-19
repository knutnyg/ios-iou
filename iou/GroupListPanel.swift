//
//  GroupPanelParent.swift
//  iou
//
//  Created by Knut Nygaard on 3/9/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class GroupListPanel : UIViewController {
    
    var headerView:HeaderView!
    var groupPanel:GroupListTableViewController!
    var views:[String : AnyObject]!
    var activeUser:ActiveUser!
    
    override func viewDidLoad(){
        headerView = HeaderView()
        headerView.view.translatesAutoresizingMaskIntoConstraints = false
        headerView.view.backgroundColor = UIColor.orangeColor()
        
        groupPanel = GroupListTableViewController(activeUser: activeUser)
        groupPanel.view.translatesAutoresizingMaskIntoConstraints = false
        groupPanel.view.backgroundColor = UIColor.purpleColor()
        
        self.addChildViewController(headerView)
        self.addChildViewController(groupPanel)
        
        view.addSubview(headerView.view)
        view.addSubview(groupPanel.view)
        
        views = ["header":headerView.view,"group":groupPanel.view]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[header]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[group]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[header(30)]-[group]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    /* ----   Initializers   ----  */
    
    init(activeUser:ActiveUser) {
        super.init(nibName: nil, bundle: nil)
        self.activeUser = activeUser
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Here you can init your properties
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
