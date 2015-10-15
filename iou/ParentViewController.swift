//
//  parentViewController.swift
//  iou
//
//  Created by Knut Nygaard on 3/5/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class ParentViewController : UIViewController {
    
    var profileView:ProfileViewController!
    var groupPanelView:GroupListPanel!
    var label:UILabel!
    
    override func viewDidLoad(){
        
        setupNavigationBar()
    
        profileView = ProfileViewController()
        profileView.view.translatesAutoresizingMaskIntoConstraints = false
        
        groupPanelView = GroupListPanel()
        groupPanelView.view.translatesAutoresizingMaskIntoConstraints = false
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "tonaowda"
        label.backgroundColor = UIColor.blueColor()
        
        self.addChildViewController(profileView)
        self.addChildViewController(groupPanelView)
        
        view.addSubview(profileView.view)
        view.addSubview(groupPanelView.view)
        view.addSubview(label)
        
        let views:[String : AnyObject] = ["profile":profileView.view,"groupPanel":groupPanelView.view, "label":label]
        
        let profileHeight = 200
        
        var visualFormat = String(format: "V:|-63-[profile(%d)]-0-[groupPanel]-0-[label(30)]-|",
            profileHeight
        )
        
        let verticalLayout = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        visualFormat = "H:|-0-[profile]-0-|"
        let profileWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        visualFormat = "H:|-0-[groupPanel]-0-|"
        let groupPanelWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        visualFormat = "H:|-0-[label]-0-|"
        let buttonWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        view.addConstraints(verticalLayout)
        view.addConstraints(profileWidth)
        view.addConstraints(groupPanelWidth)
        view.addConstraints(buttonWidth)

    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor(netHex: 0x123add)
        
        var font = UIFont(name: "Verdana", size:22)!
        var attributes:[String : AnyObject] = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationItem.title = "IOU"
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        var verticalOffset = 1.5 as CGFloat;
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(verticalOffset, forBarMetrics: UIBarMetrics.Default)
    }
}
