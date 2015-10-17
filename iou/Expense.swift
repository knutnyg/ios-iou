//
//  Expense.swift
//  iou
//
//  Created by Knut Nygaard on 31/03/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import SwiftyJSON
import JSONJoy

class Expense :JSONJoy {
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
    
    required init(_ decoder: JSONDecoder) {
        if let p = decoder["participants"].array {
            participants = []
            for participantDecoder in p {
                participants.append(User(participantDecoder))
            }
        }
        
        amount = decoder["amount"].double
        comment = decoder["comment"].string
        date = dateFromUTCString(decoder["date"].string!)
        groupId = decoder["spreadsheet_id"].integer
        id = decoder["id"].integer
        created = dateFromUTCString(decoder["created_at"].string!)
        updated = dateFromUTCString(decoder["updated_at"].string!)
        creator = User(decoder["creator"])
        
    }

    func toJSONparsableDicitonary() -> NSDictionary{
        let participantIDs = participants.map { return ["id": $0.id] }
        
        return [
            "participants":participantIDs,
            "comment":comment,
            "date":date.utcFormat(),
            "id":id,
            "creator":creator.toJSONParseableDictionary(),
            "amount":amount,
            "created_at":created.utcFormat(),
            "spreadsheet_id":groupId,
            "updated_at":NSDate().utcFormat()
        ]
    }
}
