

import Foundation
import BrightFutures
import SwiftHTTP
import JSONJoy

class SignUpHandler {
    
    static func signUp(name:String, email:String, password: String, confirm_password:String) -> Future<String,NSError>{
        let signUpPromise = Promise<String,NSError>()
        
        let url:String = "\(API.baseUrl)/api/register"
        let payload = ["name":name, "email":email, "password":password, "confirm_password":confirm_password]
        
        do {
            let request = try HTTP.POST(url, parameters: payload, requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("SignUpHandler: Response contains error: \(err)")
                    signUpPromise.failure(err)
                    return
                }
                print("Debug: GroupHandler got response")

                if let code = response.statusCode {
                    if code != 200 {
                        print("SignUpHandler: Response was _not_ OK!")
                        signUpPromise.failure(NSError(domain: "ErrorCode", code: code, userInfo: nil))
                        return
                    }
                }

                let signUpResponse = SignUpResponse(JSONDecoder(response.data))
                
                signUpPromise.success(signUpResponse.id)
            }
            
        } catch {
            print("SignupHandler: got error in getGroupForUser")
            signUpPromise.failure(NSError(domain: "Error", code: 500, userInfo: nil))
        }
        
        return signUpPromise.future
    }
    
}