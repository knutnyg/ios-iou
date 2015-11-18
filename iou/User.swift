//
//  User.swift
//  iou
//
//  Created by Knut Nygaard on 31/03/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import SwiftyJSON
import JSONJoy

class User :JSONJoy{
    var name:String!
    var shortName:String!
    var id:String!
    var photoURL:String!
    var email:String!
    
    init(name:String, shortName:String, id:String, photoUrl:String, email:String){
        self.name = name
        self.shortName = shortName
        self.id = id
        self.photoURL = photoUrl
        self.email = email
    }
    
    func toJSONParseableDictionary() -> [String:AnyObject]{
        var returnDict:[String:AnyObject] = ["name":name,"id":id]
        
        if let sn = shortName{
            returnDict["shortname"] = sn
        }
        
        if let purl = photoURL {
            returnDict["photourl"] = purl
        }
        
        if let e = email {
            returnDict["email"] = e
        }
        
        return returnDict
    }
    
    required init(_ decoder: JSONDecoder) {
        name = decoder["name"].string
        id = decoder["id"].string
        photoURL = decoder["photourl"].string
        shortName = decoder["shortname"].string
        email = decoder["email"].string
    }
    
}