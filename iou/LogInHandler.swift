//
//  LogInHandler.swift
//  iou
//
//  Created by Knut Nygaard on 17/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import BrightFutures
import SwiftHTTP
import JSONJoy
import SwiftyJSON
import FBSDKCoreKit
import FBSDKLoginKit

class LogInHandler {

    var FBlogInPromise:Promise<String,NSError>!
    
    func logInWithDefault(username:String, password:String) -> Future<String,NSError> {
        let logInPromise = Promise<String,NSError>()
        
        let url = "https://www.logisk.org/api/login"
        let payload = ["username":username, "password":password]
        do {
            let request = try HTTP.POST(url, parameters: payload, requestSerializer:JSONParameterSerializer())

            request.start { response in
                if let err = response.error {
                    print("LoginHandler: Response contains error: \(err)")
                    logInPromise.failure(err)
                    return
                }
                print("Debug: login got response")
                print(response.description)
                
                let accessToken = AccessToken(JSONDecoder(response.data))
                logInPromise.success(accessToken.token)
            }
        } catch {
            print("LoginHandler: got error in logInWithDefault")
            logInPromise.failure(NSError(domain: "Error", code: 503, userInfo: nil))
        }
        
        return logInPromise.future
    }
    
    func logOutDefaultLogin(){
        //Delete key from storage
        
        //segue to loginscreen
    }
}