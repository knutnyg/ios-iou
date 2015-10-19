//
//  parentViewController.swift
//  iou
//
//  Created by Knut Nygaard on 3/5/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class MainViewController : UIViewController {
    
    var profileView:ProfileViewController!
    var groupPanelView:GroupListPanel!
    var delegate:UIViewController!
    var label:UILabel!
    var activeUser:ActiveUser!
    var settingsButton:UIButton!
    var settingsButtonItem:UIBarButtonItem!
    
    override func viewDidLoad(){
        
        setupNavigationBar()
    
        profileView = ProfileViewController()
        profileView.view.translatesAutoresizingMaskIntoConstraints = false
        
        groupPanelView = GroupListPanel(activeUser: activeUser)
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
        
        let font = UIFont(name: "Verdana", size:22)!
        let attributes:[String : AnyObject] = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationItem.title = "IOU"
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        let verticalOffset = 1.5 as CGFloat;
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(verticalOffset, forBarMetrics: UIBarMetrics.Default)
        
        settingsButton = createfontAwesomeButton("\u{f013}")
        settingsButton.addTarget(self, action: "settings:", forControlEvents: UIControlEvents.TouchUpInside)
        settingsButtonItem = UIBarButtonItem(customView: settingsButton)
        
        navigationItem.rightBarButtonItem = settingsButtonItem
    }
    
    func settings(sender:UIButton){
        let vc = SettingsViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
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
