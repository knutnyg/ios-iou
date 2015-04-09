//
//  SummaryItem.swift
//  iou
//
//  Created by Knut Nygaard on 4/6/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation

class SummaryItem {
    var imageView:UIImageView!
    var user:User!
    var amount:Double!
    
    init(imageView:UIImageView, user:User, amount:Double){
        self.imageView = imageView
        self.user = user
        self.amount = amount
    }
}
