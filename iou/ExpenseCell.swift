//
//  GroupCell.swift
//  iou
//
//  Created by Knut Nygaard on 3/9/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class ExpenseCell : UITableViewCell {
    
    var payee:UILabel!
    var date:UILabel!
    var comment:UILabel!
    var amount:UILabel!
    var split:UILabel!
    
    var expense:Expense!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        payee = createLabel()
        date = createLabel()
        comment = createLabel()
        amount = createLabel()
        split = createLabel()
        
        contentView.addSubview(payee)
        contentView.addSubview(date)
        contentView.addSubview(comment)
        contentView.addSubview(amount)
        contentView.addSubview(split)
        
        let views:[NSObject : AnyObject] = ["payee":payee, "date":date, "comment":comment, "amount":amount, "split":split]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[payee(50)]-[date(40)]-[comment(100)]-[amount(50)]-[split(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[payee]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[date]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[comment]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[amount]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[split]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))

    }
    
    func updateLabels(){
        
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        if(self.expense.creator.shortName.isEmpty) {
            payee.text = self.expense.creator.name
        } else {
            payee.text = self.expense.creator.shortName
        }

        date.text = self.expense.date.shortPrintable()
        comment.text = self.expense.comment
        amount.text = String(format: "%.2f", self.expense.amount)
        split.text = String(format: "%.2f", (self.expense.amount / Double(self.expense.participants.count)))
    }
    
    func createLabel() -> UILabel{
        var label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = ""
        label.font = UIFont(name: "Helvetica", size: 12)
        return label
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
