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
    var id:String!
    var archived:Bool!
    var created:NSDate!
    var description:String!
    var lastUpdated:NSDate!
    var creator:User!
    var expenses:[Expense] = []

    init(){

    }

    init(members:[User], id:String, archived:Bool, created:NSDate, description:String, lastUpdated:NSDate, creator:User, expenses:[Expense]){
        self.members = members
        self.id = id
        self.archived = archived
        self.created = created
        self.description = description
        self.lastUpdated = lastUpdated
        self.creator = creator
        self.expenses = expenses
    }
    
    required init(_ decoder: JSONDecoder) {
        if let m = decoder["members"].array {
            members = []
            for memberDecoder in m {
                members.append(User(memberDecoder))
            }
        }
        
        id = decoder["id"].string
        archived = decoder["archived"].bool
        if let t = decoder["created_at"].string {
            created = dateFromUTCString(t)
        }

        description = decoder["description"].string
        lastUpdated = dateFromUTCString(decoder["updated_at"].string!)
        creator = User(decoder["creator"])
        

        if let e = decoder["receipts"].array {
            expenses = []
            for exp in e {
                expenses.append(Expense(exp))
            }
            
        }
        
        for expense in expenses {
            populateCreatorIfNotSet(expense, members: members)
        }
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
    
    func populateCreatorIfNotSet(expense:Expense, members:[User]){
        if expense.creator.name == nil{
            if let user = findUserById(expense.creator.id, members: members) {
                print("Manual setting creator!")
                expense.creator = user
            }
        }
    }
    
    func findUserById(id:String, members:[User]) -> User?{
        for user in members {
            if user.id == id {
                return user
            }
        }
        return nil
    }

    
}