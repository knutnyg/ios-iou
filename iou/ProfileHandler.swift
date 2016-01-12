//
// Created by Knut Nygaard on 01/11/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import BrightFutures
import SwiftHTTP

class ProfileHandler {

    func getImageForUser(user:User) -> Future<UIImage,NSError> {

        guard var photoUrl = user.photoURL else {
            return Future(error: NSError(domain: "NO IMAGE URL", code: 500, userInfo: nil))
        }
        
        if !user.photoURL.containsString("http") {
            photoUrl = "\(API.url_root)\(photoUrl)"
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
                let image = UIImage(data: response.data)

                promise.success(image!)
            }
        } catch {
            print("PromiseHandler: got error in getImageForUser")
            promise.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        return promise.future
    }
}
