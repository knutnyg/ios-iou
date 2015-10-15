//
//  HeaderView.swift
//  iou
//
//  Created by Knut Nygaard on 3/9/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class HeaderView : UIViewController {
    
    var groupName:UILabel!
    var members:UILabel!
    
    override func viewDidLoad() {
        groupName = UILabel()
        groupName.translatesAutoresizingMaskIntoConstraints = false
        groupName.text = "Group title"
        groupName.font = UIFont(name: "Helvetica-Bold", size: 15)
        members = UILabel()
        members.translatesAutoresizingMaskIntoConstraints = false
        members.text = "Members"
        members.font = UIFont(name: "Helvetica-Bold", size: 15)
        
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(groupName)
        view.addSubview(members)
        
        let views:[String : AnyObject] = ["groupName":groupName, "memberCount":members]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[groupName]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[memberCount]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[groupName]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[memberCount]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
}