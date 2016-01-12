
import Foundation
import BrightFutures
import SwiftyJSON
import SwiftHTTP
import JSONJoy


class UserHandler {
    
    static func getUser(token:String) -> Future<User,NSError> {
        
        let promiseUser = Promise<User, NSError>()
        
        let url:String = "\(API.url_root)/api/user"
        do {
            let request = try HTTP.GET(url, headers: ["AccessToken":token], requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("UserHandler: Response contains error: \(err)")
                    promiseUser.failure(err)
                    return
                }
                print("Debug: UserHandler got response")
                print(response.description)
                promiseUser.success(User(JSONDecoder(response.data)))
            }
            
        } catch {
            print("UserHandler: got error in getUser")
            promiseUser.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        
        return promiseUser.future
    }
    
    func searchUser(token:String, query:String) -> Future<[User],NSError> {
        let searchPromise = Promise<[User], NSError>()
        let encodedString = query.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        print(encodedString)
        
        let url:String = "\(API.url_root)/api/users/search/\(encodedString!)"
        
        do {
            let request = try HTTP.GET(url, headers: ["AccessToken":token], requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("UserHandler: Response contains error: \(err)")
                    searchPromise.failure(err)
                    return
                }
                print("Debug: UserHandler got response")
                print(response.description)
                
                
                
                searchPromise.success(UserList(JSONDecoder(response.data)).users)
            }
            
        } catch {
            print("UserHandler: got error in getUser")
            searchPromise.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        
        return searchPromise.future

    }
    
    static func uploadImage(token:String, image:UIImage) -> Future<GenericResponse,NSError> {
        let imagePromise = Promise<GenericResponse, NSError>()
        
        let url:String = "\(API.url_root)/api/user/photo"

        let imageData = UIImagePNGRepresentation(image)!
        let base64String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        let payload:[String:AnyObject] = ["content": base64String, "media_type": "image/png"]
        
        do {
            let request = try HTTP.POST(url, parameters: payload, headers: ["AccessToken":token], requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                let genericResponse = GenericResponse(JSONDecoder(response.data))
                
                print(response.description)
                
                if response.statusCode != 201 {
                    print("Responsecode != 201")
                    imagePromise.failure(NSError(domain: "Got responsecode != 201", code: response.statusCode!, userInfo: nil))
                    return
                }
                
                if let error = genericResponse.error {
                    if error != "" {
                        print("UserHandler: Response contains error: \(error)")
                        imagePromise.failure(NSError(domain: error, code: 500, userInfo: nil))
                        return
                    }
                }
                
                if let success = genericResponse.success {
                    if success != true {
                        print("Requst got failure")
                        imagePromise.failure(NSError(domain: "Request not success!", code: 500, userInfo: nil))
                        return
                    }
                }
                
                print("Debug: UserHandler got response")
                print(response.description)
                
                imagePromise.success(GenericResponse(JSONDecoder(response.data)))
            }
            
        } catch {
            print("UserHandler: got error in getUser")
            imagePromise.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        
        return imagePromise.future
    }
    
    static func updateUser(token:String, user:User) -> Future<User,NSError> {
        
        let promiseUser = Promise<User, NSError>()
        let payload = user.toJSONParseableDictionary()
        
        let url:String = "\(API.url_root)/api/user/edit"
        do {
            let request = try HTTP.PUT(url, parameters: payload, headers: ["AccessToken":token], requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("UserHandler: Response contains error: \(err)")
                    promiseUser.failure(err)
                    return
                }
                print("Debug: UserHandler got response")
                print(response.description)
                promiseUser.success(User(JSONDecoder(response.data)))
            }
            
        } catch {
            print("UserHandler: got error in getUser")
            promiseUser.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        
        return promiseUser.future
    }
    
    
}


