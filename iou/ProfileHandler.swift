

import Foundation
import BrightFutures
import SwiftHTTP

class ProfileHandler {

    static func getImageForUser(user:User) -> Future<UIImage,NSError> {

        guard var photoUrl = user.photoURL else {
            return Future(error: NSError(domain: "NO IMAGE URL", code: 500, userInfo: nil))
        }

        //Denne burde kunne fjernes
        if !user.photoURL.containsString("http") {
            photoUrl = "\(API.baseUrl)\(photoUrl)"
        }

        if API.baseUrl.containsString("dev"){
            let index = photoUrl.rangeOfString("/api/")!.startIndex
            photoUrl = API.baseUrl + photoUrl.substringFromIndex(index)
        }

        let promise = Promise<UIImage, NSError>()

        do {
            let request = try HTTP.GET(photoUrl)

            request.start { response in
                if let err = response.error {
                    print("ProfileHandler: Response contains error: \(err)")
                    promise.failure(err)
                    return
                }
                print("Debug: PromiseHandler got response")
                if let image = UIImage(data: response.data) {
                    promise.success(image)
                } else {
                    promise.failure(NSError(domain: "Image not found", code: 404, userInfo: nil))
                }



            }
        } catch {
            print("PromiseHandler: got error in getImageForUser")
            promise.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        return promise.future
    }
}
