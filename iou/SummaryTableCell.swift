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
        
        nameLabel = createLabel()
        paidLabel = createLabel()
        owesLabel = createLabel()
        sumLabel = createLabel()
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(paidLabel)
        contentView.addSubview(owesLabel)
        contentView.addSubview(sumLabel)
        
        let views = ["name":nameLabel, "paid":paidLabel, "owes":owesLabel, "sum":sumLabel]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[name]-[paid(80)]-[owes(80)]-[sum(80)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[name]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[paid]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[owes]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[sum]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
    }


    
    func updateLabels(name:String, paid:Double, owes:Double){
        nameLabel.text = name
        paidLabel.text = String(format: "%.2f", paid)
        owesLabel.text = String(format: "%.2f", owes)
        sumLabel.text = String(format: "%.2f", (paid - owes))
    }
    
    
    func createLabel() -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont(name: "Helvetica", size: 14)
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

