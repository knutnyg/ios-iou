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
    var id:Int!
    var photoURL:String!
    
    init(name:String, shortName:String, id:Int, photoUrl:String){
        self.name = name
        self.shortName = shortName
        self.id = id
        self.photoURL = photoUrl
    }
    
    func toDictionary() -> [String:AnyObject]{
        return ["name":name, "shortname":shortName, "id":id, "photourl":photoURL]
    }
    
    required init(_ decoder: JSONDecoder) {
        name = decoder["name"].string
        id = decoder["id"].integer
        photoURL = decoder["photourl"].string
        shortName = decoder["shortname"].string
    }
    
}