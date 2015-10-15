//
//  GroupList.swift
//  iou
//
//  Created by Knut Nygaard on 15/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import JSONJoy

class GroupList : JSONJoy{
    var groups:[Group]!
    
    
    init(groups:[Group]){
        self.groups = groups
    }
    
    required init(_ decoder: JSONDecoder) {
        if let g = decoder.array {
            groups = []
            for groupDecoder in g {
                groups.append(Group(groupDecoder))
            }
        }
    }
    
}