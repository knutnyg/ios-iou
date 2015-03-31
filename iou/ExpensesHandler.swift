//
//  File.swift
//  iou
//
//  Created by Knut Nygaard on 31/03/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import BrightFutures
import SwiftyJSON

class ExpensesHandler : NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate{

    var data:NSMutableData!
    var promise:Promise<[Expense]>!
    
    override init(){
        super.init()
        data = NSMutableData()
    }
    
    func getExpensesForGroup(id:Int) -> Future<[Expense]> {
        
        promise = Promise<[Expense]>()
        
        var accessToken:String = "eyJpZCI6MywiZW1haWwiOiJrbnV0bnlnQGdtYWlsLmNvbSIsIm5hbWUiOiJLbnV0IE55Z2FhcmQiLCJzaG9ydG5hbWUiOiJLbnV0IiwicGhvdG91cmwiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLWYtaXBlRmVUY09vL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUV3L0NfcW9wRGxKb200L3Bob3RvLmpwZz9zej01MCIsInNlY3JldCI6IjRjY2U3NGY0YmNhZjMwZDY2ZGRjMzVmMDUxZjM4MjI2MzExNDY0NWQyOTJiOGM3NGQxNWI3OTlhNGYxYzdmNmIiLCJjcmVhdGVkX2F0IjoiMjAxNS0wMy0zMVQxMDo1NjoyNy4yNjM2NDM0MTdaIn0="
        
        let urlString = "https://ioubeta.logisk.org/api/spreadsheets/\(id)"
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
        
        //create list of receipts
        
        var receipeList:[Expense] = []
        
        for (index, receipeJSON) in json["receipts"] {
            receipeList += [createRecepieFromJSON(receipeJSON)]
        }
        
        return promise.success(receipeList)
    }
    
    func createRecepieFromJSON(json:JSON) -> Expense{
        
        var amount = json["amount"].double
        var groupId = json["spreadsheet_id"].int
        var id = json["id"].int
        var created = JSONHelpers.createDateFromISOString(json["created_at"].stringValue)
        var date = JSONHelpers.createDateFromISOString(json["date"].stringValue)
        var participants = JSONHelpers.createUserListFromJSON(json["participants"])

        var updatedString = json["updated_at"].stringValue
        var updated = JSONHelpers.createDateFromISOString(json["updated_at"].stringValue)
        var comment = json["comment"].stringValue
        var creator = JSONHelpers.createUserFromJSON(json["creator"])
        
        return Expense(participants: participants, amount: amount!, date: date, groupId: groupId!, id: id!, created: created, updated: updated, comment: comment, creator: creator)
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


