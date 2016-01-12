
import Foundation
import JSONJoy

class AccessToken : JSONJoy {
    var token:String!
    
    init(token:String){
        self.token = token
    }
    
    required init(_ decoder: JSONDecoder) {
        token = decoder["token"].string
    }
    
    
    
}
