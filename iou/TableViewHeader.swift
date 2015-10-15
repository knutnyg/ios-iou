//
//  HeaderView.swift
//  iou
//
//  Created by Knut Nygaard on 3/9/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class TableViewHeader : UIViewController {
    
    var payee:UILabel!
    var date:UILabel!
    var comment:UILabel!
    var amount:UILabel!
    var split:UILabel!
    
    override func viewDidLoad() {
        
        payee = createLabelWithText("Payee")
        date = createLabelWithText("Date")
        comment = createLabelWithText("Comment")
        amount = createLabelWithText("Amount")
        split = createLabelWithText("Split")
        
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(payee)
        view.addSubview(date)
        view.addSubview(comment)
        view.addSubview(amount)
        view.addSubview(split)
        
        let views:[String : AnyObject] = ["payee":payee, "date":date,"comment":comment,"amount":amount,"split":split]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[payee]-[date]-[comment]-[amount]-[split]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[payee]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[date]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[comment]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[amount]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[split]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    func createLabelWithText(text:String) -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont(name: "Helvetica-Bold", size: 15)
        return label
    }
}