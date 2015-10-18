//
//  SignUpHandler.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import BrightFutures
import SwiftHTTP
import JSONJoy

class SignUpHandler {
    
    var signUpPromise:Promise<Int, NSError>!
    
    func signUp(name:String, email:String, password: String, confirm_password:String) -> Future<Int,NSError>{
        signUpPromise = Promise<Int,NSError>()
        
        let url:String = "https://www.logisk.org/api/register"
        let payload = ["name":name, "email":email, "password":password, "confirm_password":confirm_password]
        
        do {
            let request = try HTTP.PUT(url, parameters: payload, requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("SignUpHandler: Response contains error: \(err)")
                    self.signUpPromise.failure(err)
                    return
                }
                print("Debug: GroupHandler got response")
                let signUpResponse = SignUpResponse(JSONDecoder(response.data))
                
                self.signUpPromise.success(signUpResponse.id)
            }
            
        } catch {
            print("GroupHandler: got error in getGroupForUser")
            self.signUpPromise.failure(NSError(domain: "Error", code: 500, userInfo: nil))
        }
        
        return signUpPromise.future
    }
    
}