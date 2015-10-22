
import Foundation
import BrightFutures
import SwiftyJSON
import SwiftHTTP
import JSONJoy


class UserHandler {
    
    var promiseUser:Promise<User,NSError>!
    
    func getUser(token:String) -> Future<User,NSError> {
        
        promiseUser = Promise<User, NSError>()
        
        let url:String = "https://www.logisk.org/api/user"
        do {
            let request = try HTTP.GET(url, headers: ["AccessToken":token], requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("UserHandler: Response contains error: \(err)")
                    self.promiseUser.failure(err)
                    return
                }
                print("Debug: UserHandler got response")
                print(response.description)
                self.promiseUser.success(User(JSONDecoder(response.data)))
            }
            
        } catch {
            print("UserHandler: got error in getUser")
            self.promiseUser.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        
        return promiseUser.future
    }
}


