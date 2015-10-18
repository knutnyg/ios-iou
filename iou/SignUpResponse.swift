//
//  SignUpResponse.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import JSONJoy

class SignUpResponse : JSONJoy {
    var id:Int!
    
    init(id:Int){
        self.id = id
    }
    
    required init(_ decoder: JSONDecoder) {
        id = decoder["id"].integer
    }
}