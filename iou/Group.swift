//
//  Group.swift
//  iou
//
//  Created by Knut Nygaard on 31/03/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import JSONJoy

class Group : JSONJoy{
    var members:[User]!
    var id:Int!
    var archived:Bool!
    var created:NSDate!
    var description:String!
    var lastUpdated:NSDate!
    var creator:User!
    
    init(members:[User], id:Int, archived:Bool, created:NSDate, description:String, lastUpdated:NSDate, creator:User){
        self.members = members
        self.id = id
        self.archived = archived
        self.created = created
        self.description = description
        self.lastUpdated = lastUpdated
        self.creator = creator
    }
    
    required init(_ decoder: JSONDecoder) {
        if let m = decoder["members"].array {
            members = []
            for memberDecoder in m {
                members.append(User(memberDecoder))
            }
        }
        
        id = decoder["id"].integer
        archived = decoder["archived"].bool
        if let t = decoder["created_at"].string {
            created = dateFromUTCString(t)
        }

        description = decoder["description"].string
        lastUpdated = dateFromUTCString(decoder["updated_at"].string!)
        creator = User(decoder["creator"])
    }
    
    func toJSONparsableDicitonary() -> [String:AnyObject]{
        return [
            "members":members.map{member in member.toJSONParseableDictionary()},
            "id":id,
            "archived":archived,
            "created_at":created.utcFormat(),
            "description":description,
            "updated_at":lastUpdated.utcFormat(),
            "creator":creator.toJSONParseableDictionary()
        ]
    }
    
}