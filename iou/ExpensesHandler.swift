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
import SwiftHTTP
import JSONJoy

class ExpensesHandler : NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate{

    var promise:Promise<[Expense]>!
    
    var accessToken = "eyJpZCI6MywiZW1haWwiOiJrbnV0bnlnQGdtYWlsLmNvbSIsIm5hbWUiOiJLbnV0IE55Z2FhcmQiLCJzaG9ydG5hbWUiOiJLbnV0IiwicGhvdG91cmwiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLWYtaXBlRmVUY09vL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUV3L0NfcW9wRGxKb200L3Bob3RvLmpwZz9zej01MCIsInNlY3JldCI6IjJhN2U2ZGUzOGFiMDBiYmVmNTNhYzQxOGY3MmFiNGVjNDM1MzVkZmI0NDYyZTZiNjRkOWI0MWI4YWI4OGFmMGIiLCJjcmVhdGVkX2F0IjoiMjAxNS0wNC0wMlQwNTozMTowMy4zNTc0MjMxNFoifQ=="
    
    func readResponseFromFile() -> JSON{
        let path = NSBundle.mainBundle().pathForResource("expenseResponse", ofType: "txt")
        var data = NSData(contentsOfFile: path!)!
        //        var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        return JSON(data: data)
    }
    
    
    func getExpensesForGroup(group:Group) -> Future<[Expense]> {
        
        promise = Promise<[Expense]>()
        
        let urlString = "https://ioubeta.logisk.org/api/spreadsheets/\(group.id)"
        let request = HTTPTask()
        request.requestSerializer = JSONRequestSerializer()
        request.responseSerializer = JSONResponseSerializer()
        request.requestSerializer.headers["AccessToken"] = accessToken //example of adding a header value
        
        request.GET(urlString, parameters: nil,
            success:
            {(response: HTTPResponse) in
                var expenses:[Expense] = []

                if response.responseObject != nil {
                    if let dict = response.responseObject as? Dictionary<String,AnyObject> {
                        var expenseList = dict["receipts"] as! [AnyObject]
                        var membersList = dict["members"] as! [AnyObject]
                        
                        for expense in expenseList {
                            var exp:Expense = Expense(JSONDecoder(expense))
                            if exp.creator.name == nil {
                                self.populateCreatorIfNotSet(exp, members: group.members)
                            }
                            expenses.append(exp)
                        }
                    }
                }
                self.promise.success(expenses)
                
            },
            failure:
            {(error: NSError, response: HTTPResponse?) in
                println("error editing recepit")
                self.promise.failure(error)
        })
        
        return promise.future
    }
    
    func createExpense(expense:Expense) {
        
    }
    
    func updateExpense(expense:Expense){
        let urlString = "https://ioubeta.logisk.org/api/spreadsheets/\(expense.groupId)/receipts/\(expense.id)"
        
        var request = HTTPTask()
        request.requestSerializer = JSONRequestSerializer()
        request.requestSerializer.headers["AccessToken"] = accessToken //example of adding a header value
        
        var payload:[String:AnyObject] = expense.toJSONparsableDicitonary() as! [String : AnyObject]
        
        request.PUT(urlString, parameters: payload,
            success:
            {(response: HTTPResponse) in
                println("success editing receipt!")
            },
            failure:
            {(error: NSError, response: HTTPResponse?) in
                println("error editing recepit")
            })

        

    }
    
    func populateCreatorIfNotSet(expense:Expense, members:[User]){
        if expense.creator.name == nil{
            if let user = findUserById(expense.creator.id, members: members) {
                expense.creator = user
            }
        }
    }
    
    func findUserById(id:Int, members:[User]) -> User?{
        for user in members {
            if user.id == id {
                return user
            }
        }
        return nil
    }
}


