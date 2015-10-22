//
//  UserList.swift
//  iou
//
//  Created by Knut Nygaard on 22/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import JSONJoy

class UserList : JSONJoy{
    var users:[User]!
    
    
    init(users:[User]){
        self.users = users
    }
    
    required init(_ decoder: JSONDecoder) {
        if let u = decoder.array {
            users = []
            for userDecoder in u {
                users.append(User(userDecoder))
            }
        }
    }
    
}