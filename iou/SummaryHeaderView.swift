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
//    var owedLabel:UILabel!
    var sumLabel:UILabel!
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        memberLabel = createLabel("Name:", font: UIFont(name: "HelveticaNeue-Bold", size: 19)!)
        paidLabel = createLabel("Paid/Owed:", font: UIFont(name: "HelveticaNeue-Bold", size: 19)!)
        paidLabel.textAlignment = NSTextAlignment.Right
//        owedLabel = createLabel("Owes:", font: UIFont(name: "HelveticaNeue-Bold", size: 19)!)
        sumLabel = createLabel("Sum:", font: UIFont(name: "HelveticaNeue-Bold", size: 19)!)
        sumLabel.textAlignment = NSTextAlignment.Right
        
        view.addSubview(memberLabel)
        view.addSubview(paidLabel)
//        view.addSubview(owedLabel)
        view.addSubview(sumLabel)
        
        let views = ["member":memberLabel, "paid":paidLabel,"sum":sumLabel]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[member]-[paid(120)]-[sum(100)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[member]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[paid]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[owed(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[sum]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
}
    

    
    
    
    
    
}