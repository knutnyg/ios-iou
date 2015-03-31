//
//  Group.swift
//  iou
//
//  Created by Knut Nygaard on 31/03/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation

class Group {
    var members:[User]!
    var id:Int!
    var archived:Bool!
    var created:NSDate!
    var description:String!
    var lastUpdated:NSDate!
    var creator:Int!
    
    init(members:[User], id:Int, archived:Bool, created:NSDate, description:String, lastUpdated:NSDate, creator:Int){
        self.members = members
        self.id = id
        self.archived = archived
        self.created = created
        self.description = description
        self.lastUpdated = lastUpdated
        self.creator = creator
    }
    
}