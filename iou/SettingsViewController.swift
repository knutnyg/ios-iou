//
//  SettingsViewController.swift
//  iou
//
//  Created by Knut Nygaard on 19/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    var logOutButton:UIButton!
    var delegate:UIViewController!
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        logOutButton = createButton("Log Out")
        logOutButton.addTarget(self, action: "logOutPressed:", forControlEvents: .TouchUpInside)
        
        let views = ["logOutButton":logOutButton]
        
        view.addSubview(logOutButton)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[logOutButton(40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: logOutButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: logOutButton, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
    }
    
    func logOutPressed(sender:UIButton){

        NSUserDefaults.standardUserDefaults().setValue("", forKey: "DefaultAccessToken")
        navigationController?.popToRootViewControllerAnimated(true)
        
    
    }
}