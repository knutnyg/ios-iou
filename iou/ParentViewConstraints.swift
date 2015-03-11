//
//  parentViewConstraints.swift
//  iou
//
//  Created by Knut Nygaard on 3/8/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation

class ParentViewConstraints : NSObject{
    let bannerHeight:Int
    let profileViewHeight:Int
    let groupViewHeight:Int
    let cellHeight:Int
    
    init(bannerHeight:Int, profileViewHeight:Int, groupViewHeight:Int, cellHeight:Int){
        self.bannerHeight = bannerHeight
        self.profileViewHeight = profileViewHeight
        self.groupViewHeight = groupViewHeight
        self.cellHeight = cellHeight
    }
}
