//
//  ResetPasswordHandler.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import BrightFutures
import SwiftHTTP
import JSONJoy

class ResetPasswordHandler {
    
    var resetPasswordPromise:Promise<Bool, NSError>!
    
    func resetPassword(email:String) -> Future<Bool,NSError>{
        resetPasswordPromise = Promise<Bool,NSError>()
        
        let url:String = "\(API.url_root)/api/user/forgot"
        let payload = ["email":email]
        
        do {
            let request = try HTTP.POST(url, parameters: payload, requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("ResetPasswordHandler: Response contains error: \(err)")
                    self.resetPasswordPromise.failure(err)
                    return
                }
                print("Debug: ResetPasswordHandler got response")
                
                if response.statusCode == 200 {
                    self.resetPasswordPromise.success(true)
                } else {
                    self.resetPasswordPromise.failure(NSError(domain: "HTTPError", code: response.statusCode!, userInfo: nil))
                }
            }
        } catch {
            print("GroupHandler: got error in getGroupForUser")
            self.resetPasswordPromise.failure(NSError(domain: "Error", code: 500, userInfo: nil))
        }
        
        return resetPasswordPromise.future
    }
    
}