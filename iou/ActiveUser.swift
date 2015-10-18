//
//  ActiveUser.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation

class ActiveUser {
    var accessToken:String?
    
    init(){
        
    }
    
    init(accessToken:String){
        self.accessToken = accessToken
    }
}
