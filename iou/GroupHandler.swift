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
    var mockData:Bool = false
    
    override init(){
        super.init()
        data = NSMutableData()
    }
    
    func readResponseFromFile() -> JSON{
        let path = NSBundle.mainBundle().pathForResource("groupResponse", ofType: "txt")
        var data = NSData(contentsOfFile: path!)!
//        var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        return JSON(data: data)
    }
    
    func getGroupsForUser() -> Future<[Group]> {
        
        promise = Promise<[Group]>()
        
        if mockData {
            var groups = createGroupsFromJSON(self.readResponseFromFile())
            promise.success(groups)
            return promise.future
        }
        
        
        var accessToken:String = "eyJpZCI6MywiZW1haWwiOiJrbnV0bnlnQGdtYWlsLmNvbSIsIm5hbWUiOiJLbnV0IE55Z2FhcmQiLCJzaG9ydG5hbWUiOiJLbnV0IiwicGhvdG91cmwiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLWYtaXBlRmVUY09vL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUV3L0NfcW9wRGxKb200L3Bob3RvLmpwZz9zej01MCIsInNlY3JldCI6IjJhN2U2ZGUzOGFiMDBiYmVmNTNhYzQxOGY3MmFiNGVjNDM1MzVkZmI0NDYyZTZiNjRkOWI0MWI4YWI4OGFmMGIiLCJjcmVhdGVkX2F0IjoiMjAxNS0wNC0wMlQwNTozMTowMy4zNTc0MjMxNFoifQ=="
        
        let urlString = "https://ioubeta.logisk.org/api/spreadsheets"
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        request.setValue(accessToken, forHTTPHeaderField: "AccessToken")

        var connection:NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!

        return promise.future
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData!) {
        self.data.appendData(data)
    }
    
    
    func createGroupsFromJSON(json:JSON)-> [Group]{
        var groups:[Group] = []
        
        for (index,j:JSON) in json {
            groups += [createGroup(j)]
        }
        
        return groups

    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var err: NSError
        let json = JSON(data: data)
        
        var groups = createGroupsFromJSON(json)
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