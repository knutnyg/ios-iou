//
//  GroupPanelConstraints.swift
//  iou
//
//  Created by Knut Nygaard on 3/11/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation

class GroupPanelConstraints : NSObject{
    let bannerHeight:Int
    let summaryHeight:Int
    let datepickerHeight:Int
    let expensesHeight:Int
    let cellHeight:Int
    
    init(bannerHeight:Int, summaryHeight:Int, datepickerHeight:Int, expensesHeight:Int, cellHeight:Int){
        self.bannerHeight = bannerHeight
        self.summaryHeight = summaryHeight
        self.datepickerHeight = datepickerHeight
        self.expensesHeight = expensesHeight
        self.cellHeight = cellHeight
    }
}
