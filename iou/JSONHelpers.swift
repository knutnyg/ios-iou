//
//  JSONHelpers.swift
//  iou
//
//  Created by Knut Nygaard on 31/03/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONHelpers {
    
    class func createDateFromISOString(dateString:String) -> NSDate {
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.dateFromString(dateString)!
    }
    
    class func createUserFromJSON(json:JSON) -> User{
        var name = json["name"].stringValue
        var id = json["id"].int
        var photoURL = json["photourl"].stringValue
        var shortName = json["shortname"].stringValue
        
        return User(name: name, shortName: shortName, id: id!, photoUrl: photoURL)
    }
    
    class func createUserListFromJSON(usersJSON:JSON) -> [User] {
        var userList:[User] = []
        for (index:String,userJSON:JSON) in usersJSON {
            userList += [self.createUserFromJSON(userJSON)]
        }
        return userList
    }
}