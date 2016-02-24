//
//  SummaryTableCell.swift
//  iou
//
//  Created by Knut Nygaard on 19/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class SummaryTableViewCell : UITableViewCell {
    
    var nameLabel:UILabel!
    var paidLabel:UILabel!
    var owesLabel:UILabel!
    var sumLabel:UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = createLabel("", font: UIFont(name: "HelveticaNeue", size: 15)!)
        paidLabel = createLabel("", font: UIFont(name: "HelveticaNeue", size: 15)!)
        owesLabel = createLabel("", font: UIFont(name: "HelveticaNeue", size: 15)!)
        sumLabel = createLabel("", font: UIFont(name: "HelveticaNeue", size: 15)!)
        owesLabel.textAlignment = NSTextAlignment.Right
        paidLabel.textAlignment = NSTextAlignment.Right
        sumLabel.textAlignment = NSTextAlignment.Right
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(paidLabel)
        contentView.addSubview(owesLabel)
        contentView.addSubview(sumLabel)
        
        let views = ["name":nameLabel, "paid":paidLabel, "owes":owesLabel, "sum":sumLabel]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[name]-[paid(100)]-[sum(100)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraint(NSLayoutConstraint(item: owesLabel, attribute: .Width, relatedBy: .Equal, toItem: paidLabel, attribute: .Width, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: owesLabel, attribute: .CenterX, relatedBy: .Equal, toItem: paidLabel, attribute: .CenterX, multiplier: 1, constant: 0))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[name]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[paid]-2-[owes]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
//        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0--0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[sum]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
    }


    
    func updateLabels(name:String, paid:Double, owes:Double){
        nameLabel.text = name
        paidLabel.text = localeStringFromNumber(NSLocale(localeIdentifier: "nb_NO"), number: paid)
        owesLabel.text = localeStringFromNumber(NSLocale(localeIdentifier: "nb_NO"), number: owes)
        sumLabel.text = localeStringFromNumber(NSLocale(localeIdentifier: "nb_NO"), number: paid-owes)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

