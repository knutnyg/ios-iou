//
//  GroupHandler.swift
//  iou
//
//  Created by Knut Nygaard on 3/10/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import BrightFutures
import SwiftyJSON
import SwiftHTTP
import JSONJoy


class GroupListFetcher {
    
    var promise:Promise<[Group],NSError>!
    
     var accessToken = "eyJpZCI6MywiZW1haWwiOiJrbnV0bnlnQGdtYWlsLmNvbSIsIm5hbWUiOiJLbnV0IE55Z2FhcmQiLCJzaG9ydG5hbWUiOiJLbnV0IiwicGhvdG91cmwiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLWYtaXBlRmVUY09vL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUV3L0NfcW9wRGxKb200L3Bob3RvLmpwZz9zej01MCIsInNlY3JldCI6IjJhN2U2ZGUzOGFiMDBiYmVmNTNhYzQxOGY3MmFiNGVjNDM1MzVkZmI0NDYyZTZiNjRkOWI0MWI4YWI4OGFmMGIiLCJjcmVhdGVkX2F0IjoiMjAxNS0wNC0wMlQwNTozMTowMy4zNTc0MjMxNFoifQ=="
    
    func getGroupsForUser() -> Future<[Group],NSError> {
        
        promise = Promise<[Group], NSError>()

        let url:String = "https://www.logisk.org/api/spreadsheets"
        do {
            let request = try HTTP.GET(url, headers: ["AccessToken":accessToken], requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("GroupHandler: Response contains error: \(err)")
                    self.promise.failure(err)
                    return
                }
                print("Debug: GroupHandler got response")
                let groupList = GroupList(JSONDecoder(response.data))
                
                self.promise.success(groupList.groups)
            }
            
        } catch {
            print("GroupHandler: got error in getGroupForUser")
            self.promise.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        
        return promise.future
    }
}


