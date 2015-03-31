//
//  User.swift
//  iou
//
//  Created by Knut Nygaard on 31/03/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
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
    
    
}