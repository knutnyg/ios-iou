//
//  Expense.swift
//  iou
//
//  Created by Knut Nygaard on 31/03/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation

class Expense {
    var participants:[User]!
    var amount:Double!
    var date:NSDate!
    var groupId:Int!
    var id:Int!
    var created:NSDate!
    var updated:NSDate?
    var comment:String!
    var creator:User!
    
    
    init(participants:[User], amount:Double, date:NSDate, groupId:Int, id:Int, created:NSDate, updated:NSDate?, comment:String, creator:User){
        self.participants = participants
        self.amount = amount
        self.date = date
        self.groupId = groupId
        self.id = id
        self.created = created
        self.date = date
        self.updated = updated
        self.comment = comment
        self.creator = creator
    }
}
