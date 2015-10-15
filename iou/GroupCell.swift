//
//  GroupCell.swift
//  iou
//
//  Created by Knut Nygaard on 3/9/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class GroupCell : UITableViewCell {
    
    var groupName:UILabel
    var memberCount:UILabel
    var group:Group!
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
        groupName = UILabel()
        groupName.translatesAutoresizingMaskIntoConstraints = false
        groupName.text = "gruppe1"
        memberCount = UILabel()
        memberCount.translatesAutoresizingMaskIntoConstraints = false
        memberCount.text = "4"
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(groupName)
        contentView.addSubview(memberCount)
        
        let views:[String : AnyObject] = ["name":groupName, "count":memberCount]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[name]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[count]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        contentView.addConstraint(NSLayoutConstraint(item: groupName, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: memberCount, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))


    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
