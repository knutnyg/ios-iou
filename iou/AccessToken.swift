//
//  AccessToken.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import JSONJoy

class AccessToken : JSONJoy {
    var token:String!
    
    init(token:String){
        self.token = token
    }
    
    required init(_ decoder: JSONDecoder) {
        token = decoder["token"].string
    }
    
    
    
}
