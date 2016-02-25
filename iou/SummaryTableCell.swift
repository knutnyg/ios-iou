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

        let rules = [
            ConstraintRules()
                .snapLeft(contentView.snp_left)
                .marginLeft(8)
                .snapTop(contentView.snp_top)
                .marginTop(8),
            ConstraintRules()
                .snapLeft(nameLabel.snp_right)
                .marginLeft(8)
                .width(100)
                .snapTop(contentView.snp_top),
            ConstraintRules()
                .snapLeft(nameLabel.snp_right)
                .marginLeft(8)
                .width(100)
                .snapTop(paidLabel.snp_bottom)
                .marginTop(2),
            ConstraintRules()
                .snapLeft(paidLabel.snp_right)
                .marginLeft(8)
                .width(100)
                .snapTop(contentView.snp_top)
                .marginTop(2)
                .snapRight(contentView.snp_right)
                .marginRight(8)
        ]

        let components:[UIView] = [nameLabel, paidLabel, owesLabel, sumLabel]

        SnapKitHelpers.setConstraints(contentView,components: components, rules: rules)
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

