//
//  GroupHandler.swift
//  iou
//
//  Created by Knut Nygaard on 3/10/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import BrightFutures

class GroupHandler {
    
    class func getGroups4Reals() -> Future<[(String,Int)]> {
        let list = [("Casa del Sinsen", 3), ("Spania 2013", 13), ("Famile", 4), ("Div", 2)]
        let promise = Promise<[(String,Int)]>()

        delay(3){
            promise.success(list)
        }
        
        return promise.future
    }
    
    class func get4Groups() -> [(String, Int)] {
        return [("Casa del Sinsen", 3), ("Spania 2013", 13), ("Famile", 4), ("Div", 2)]
    }
    
    
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}