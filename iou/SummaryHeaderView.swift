//
//  SummaryHeader.swift
//  iou
//
//  Created by Knut Nygaard on 19/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class SummaryHeaderView : UIViewController {
    
    var memberLabel:UILabel!
    var paidLabel:UILabel!
    var owedLabel:UILabel!
    var sumLabel:UILabel!
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        memberLabel = createLabel("Name:")
        paidLabel = createLabel("Paid:")
        owedLabel = createLabel("Owes:")
        sumLabel = createLabel("Sum:")
        
        view.addSubview(memberLabel)
        view.addSubview(paidLabel)
        view.addSubview(owedLabel)
        view.addSubview(sumLabel)
        
        let views = ["member":memberLabel, "paid":paidLabel,"owed":owedLabel,"sum":sumLabel]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[member]-[paid(60)]-[owed(60)]-[sum(60)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[member(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[paid(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[owed(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[sum(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
}
    

    
    
    
    
    
}