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

class GroupHandler: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate{
    
    var data:NSMutableData!
    var promise:Promise<[Group]>!
    
    override init(){
        super.init()
        data = NSMutableData()

    }
    
    func getGroupsForUser() -> Future<[Group]> {
        
        promise = Promise<[Group]>()
        
        var accessToken:String = "eyJpZCI6MywiZW1haWwiOiJrbnV0bnlnQGdtYWlsLmNvbSIsIm5hbWUiOiJLbnV0IE55Z2FhcmQiLCJzaG9ydG5hbWUiOiJLbnV0IiwicGhvdG91cmwiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLWYtaXBlRmVUY09vL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUV3L0NfcW9wRGxKb200L3Bob3RvLmpwZz9zej01MCIsInNlY3JldCI6IjRjY2U3NGY0YmNhZjMwZDY2ZGRjMzVmMDUxZjM4MjI2MzExNDY0NWQyOTJiOGM3NGQxNWI3OTlhNGYxYzdmNmIiLCJjcmVhdGVkX2F0IjoiMjAxNS0wMy0zMVQxMDo1NjoyNy4yNjM2NDM0MTdaIn0="
        
        let urlString = "https://ioubeta.logisk.org/api/spreadsheets"
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        request.setValue(accessToken, forHTTPHeaderField: "AccessToken")

        var connection:NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!

        return promise.future
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData!) {
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var err: NSError
        let json = JSON(data: data)
        
        var groups:[Group] = []

        for (index,j:JSON) in json {
            groups += [createGroup(j)]
        }
        promise.success(groups)
    }
    
    func createGroup(json:JSON) -> Group{
        var archived:Bool = json["archived"].boolValue
        var id:Int = json["id"].int!
        var created:NSDate = JSONHelpers.createDateFromISOString(json["created_at"].stringValue)
        var members:[User] = JSONHelpers.createUserListFromJSON(json["members"])
        var description:String = json["description"].stringValue
        
        var creator:Int = json["creator","id"].int!
        var updated:NSDate = JSONHelpers.createDateFromISOString(json["updated_at"].stringValue)
        
        return Group(members: members, id: id, archived: archived, created: created, description: description, lastUpdated: updated, creator: creator)
    }
    


    
    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace?) -> Bool
    {
        return protectionSpace?.authenticationMethod == NSURLAuthenticationMethodServerTrust
    }
    
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge?)
    {
        if challenge?.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
        {
            if challenge?.protectionSpace.host == "ioubeta.logisk.org"
            {
                let credentials = NSURLCredential(forTrust: challenge!.protectionSpace.serverTrust)
                challenge!.sender.useCredential(credentials, forAuthenticationChallenge: challenge!)
            }
        }
        
        challenge!.sender.continueWithoutCredentialForAuthenticationChallenge(challenge!)
    }
}