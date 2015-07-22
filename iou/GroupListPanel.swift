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
    var views:[NSObject : AnyObject]!
    
    override func viewDidLoad(){
        headerView = HeaderView()
        headerView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        headerView.view.backgroundColor = UIColor.orangeColor()
        
        groupPanel = GroupListTableViewController()
        groupPanel.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        groupPanel.view.backgroundColor = UIColor.purpleColor()
        
        self.addChildViewController(headerView)
        self.addChildViewController(groupPanel)
        
        view.addSubview(headerView.view)
        view.addSubview(groupPanel.view)
        
        views = ["header":headerView.view,"group":groupPanel.view]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[header]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[group]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[header(30)]-[group]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
}
