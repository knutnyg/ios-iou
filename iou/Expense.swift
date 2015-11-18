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
    var groupId:String!
    var id:String!
    var created:NSDate!
    var updated:NSDate?
    var comment:String!
    var creator:User!
    
    
    init(participants:[User], amount:Double, date:NSDate, groupId:String, created:NSDate, updated:NSDate?, comment:String, creator:User){
        self.participants = participants
        self.amount = amount
        self.date = date
        self.groupId = groupId
        self.created = created
        self.date = date
        self.updated = updated
        self.comment = comment
        self.creator = creator
    }

    init(participants:[User], amount:Double, date:NSDate, groupId:String, created:NSDate, updated:NSDate?, comment:String, creator:User, id:String){
        self.participants = participants
        self.amount = amount
        self.date = date
        self.groupId = groupId
        self.created = created
        self.date = date
        self.updated = updated
        self.comment = comment
        self.creator = creator
        self.id = id
    }
    
    init(participants:[User], amount:Double, date:NSDate, groupId:String, comment:String, creator:User){
        self.participants = participants
        self.amount = amount
        self.groupId = groupId
        self.date = date
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
        groupId = decoder["spreadsheet_id"].string
        id = decoder["id"].string
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
    
    func toJSONCreate() -> NSDictionary{
        
        return [
            "participants":participants.map{member in member.toJSONParseableDictionary()},
            "comment":comment,
            "date":date.utcFormat(),
            "creator":creator.toJSONParseableDictionary(),
            "amount":amount,
            "spreadsheet_id":groupId,
        ]
    }
}
