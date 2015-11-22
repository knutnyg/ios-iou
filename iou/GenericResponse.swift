//
//  GenericResponse.swift
//  iou
//
//  Created by Knut Nygaard on 22/11/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import SwiftyJSON
import JSONJoy

class GenericResponse {
    var message:String?
    var error:String?
    var success:Bool?
    
    required init(_ decoder: JSONDecoder) {
        message = decoder["message"].string
        error = decoder["error"].string
        success = decoder["success"].bool
    }
}
