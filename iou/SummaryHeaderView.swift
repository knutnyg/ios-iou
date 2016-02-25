//
//  SummaryHeader.swift
//  iou
//
//  Created by Knut Nygaard on 19/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class SummaryHeaderView: UIViewController {

    var memberLabel: UILabel!
    var paidLabel: UILabel!
    var sumLabel: UILabel!

    override func viewDidLoad() {

        view.backgroundColor = UIColor.whiteColor()

        memberLabel = createLabel("Name:", font: UIFont(name: "HelveticaNeue-Bold", size: 19)!)

        paidLabel = createLabel("Paid/Owed:", font: UIFont(name: "HelveticaNeue-Bold", size: 19)!)
        paidLabel.textAlignment = NSTextAlignment.Right

        sumLabel = createLabel("Sum:", font: UIFont(name: "HelveticaNeue-Bold", size: 19)!)
        sumLabel.textAlignment = NSTextAlignment.Right

        view.addSubview(memberLabel)
        view.addSubview(paidLabel)
        view.addSubview(sumLabel)

        let rules = [
                ConstraintRules()
                    .snapLeft(view.snp_left)
                    .marginLeft(8)
                    .snapTop(view.snp_top),
                ConstraintRules()
                    .snapLeft(memberLabel.snp_right)
                    .marginLeft(8)
                    .width(120)
                    .snapTop(view.snp_top),
                ConstraintRules()
                    .snapLeft(paidLabel.snp_right)
                    .marginLeft(8)
                    .width(100)
                    .snapTop(view.snp_top)
                    .snapRight(view.snp_right)
                    .marginRight(8)
        ]

        SnapKitHelpers.setConstraints(view, components: [memberLabel, paidLabel, sumLabel], rules: rules)

    }


}