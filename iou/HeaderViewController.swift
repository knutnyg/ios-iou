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
        groupName.setTranslatesAutoresizingMaskIntoConstraints(false)
        groupName.text = "Group title"
        groupName.font = UIFont(name: "Helvetica-Bold", size: 15)
        members = UILabel()
        members.setTranslatesAutoresizingMaskIntoConstraints(false)
        members.text = "Members"
        members.font = UIFont(name: "Helvetica-Bold", size: 15)
        
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(groupName)
        view.addSubview(members)
        
        let views:[NSObject : AnyObject] = ["groupName":groupName, "memberCount":members]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[groupName]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[memberCount]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[groupName]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[memberCount]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
}