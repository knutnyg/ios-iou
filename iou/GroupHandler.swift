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

class GroupHandler: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate{
    
    var data:NSMutableData!
    var promise:Promise<[Group]>!
    
     var accessToken = "eyJpZCI6MywiZW1haWwiOiJrbnV0bnlnQGdtYWlsLmNvbSIsIm5hbWUiOiJLbnV0IE55Z2FhcmQiLCJzaG9ydG5hbWUiOiJLbnV0IiwicGhvdG91cmwiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLWYtaXBlRmVUY09vL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUV3L0NfcW9wRGxKb200L3Bob3RvLmpwZz9zej01MCIsInNlY3JldCI6IjJhN2U2ZGUzOGFiMDBiYmVmNTNhYzQxOGY3MmFiNGVjNDM1MzVkZmI0NDYyZTZiNjRkOWI0MWI4YWI4OGFmMGIiLCJjcmVhdGVkX2F0IjoiMjAxNS0wNC0wMlQwNTozMTowMy4zNTc0MjMxNFoifQ=="
    
    func getGroupsForUser() -> Future<[Group]> {
        
        promise = Promise<[Group]>()
        
        let urlString = "https://ioubeta.logisk.org/api/spreadsheets/"
        let request = HTTPTask()
        var attempted = false
        request.auth = {(challenge: NSURLAuthenticationChallenge) in
            if !attempted {
                attempted = true
                return NSURLCredential(forTrust: challenge.protectionSpace.serverTrust)
            }
            return nil
        }
        request.requestSerializer = HTTPRequestSerializer()
        request.responseSerializer = JSONResponseSerializer()
        request.requestSerializer.headers["AccessToken"] = accessToken //example of adding a header value
        
        request.GET(urlString, parameters: nil,
            success:
            {(response: HTTPResponse) in
                println("got response")
                var groups:[Group] = []
                if response.responseObject != nil {
                    if let groupList = response.responseObject as? [AnyObject] {
                        for group in groupList {
                            groups.append(Group(JSONDecoder(group)))
                        }
                    }
                }
                self.promise.success(groups)
            },
            failure:
            {(error: NSError, response: HTTPResponse?) in
                println("error getting groups")
                self.promise.failure(error)
        })
        
        return promise.future
    }
}