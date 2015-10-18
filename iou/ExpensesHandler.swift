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

class ExpensesHandler {

    var promise:Promise<[Expense],NSError>!
    var updatePromise:Promise<Expense,NSError>!
    
    var accessToken = "eyJpZCI6MywiZW1haWwiOiJrbnV0bnlnQGdtYWlsLmNvbSIsIm5hbWUiOiJLbnV0IE55Z2FhcmQiLCJzaG9ydG5hbWUiOiJLbnV0IiwicGhvdG91cmwiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLWYtaXBlRmVUY09vL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUV3L0NfcW9wRGxKb200L3Bob3RvLmpwZz9zej01MCIsInNlY3JldCI6IjJhN2U2ZGUzOGFiMDBiYmVmNTNhYzQxOGY3MmFiNGVjNDM1MzVkZmI0NDYyZTZiNjRkOWI0MWI4YWI4OGFmMGIiLCJjcmVhdGVkX2F0IjoiMjAxNS0wNC0wMlQwNTozMTowMy4zNTc0MjMxNFoifQ=="
    
    func getExpensesForGroup(group:Group) -> Future<[Expense],NSError> {
        
        promise = Promise<[Expense], NSError>()
        
        let url:String = "https://www.logisk.org/api/spreadsheets/\(group.id)"
        do {
            let request = try HTTP.GET(url, headers: ["AccessToken":accessToken], requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("ExpensesListFetcher: Response contains error: \(err)")
                    self.promise.failure(err)
                    return
                }
                print("Debug: ExpensesListFetcher got response")
                
                let expenseList = ExpenseList(JSONDecoder(response.data))
                print(response.description)
                for expense in expenseList.expenses {
                    self.populateCreatorIfNotSet(expense, members: group.members)
                }

                self.promise.success(expenseList.expenses)
            }
            
        } catch {
            print("ExpensesListFetcher: got error in getExpensesForGroup")
            self.promise.failure(NSError(domain: "SSL", code: 503, userInfo: nil))
        }
        
        return promise.future
    }
    
    func updateExpense(expense:Expense) -> Future<Expense,NSError>{
        
        updatePromise = Promise<Expense,NSError>()
        
        let urlString = "https://www.logisk.org/api/spreadsheets/\(expense.groupId)/receipts/\(expense.id)"
        
        let payload:[String:AnyObject] = expense.toJSONparsableDicitonary() as! [String : AnyObject]
        do {
            let request = try HTTP.PUT(urlString, parameters: payload, headers: ["AccessToken":accessToken], requestSerializer: JSONParameterSerializer())
            request.start { response in
                if let err = response.error {
                    print("ExpensesListFetcher-updateExpense: Response contains error: \(err)")
                    self.updatePromise.failure(NSError(domain: "Update expense", code: response.statusCode!, userInfo: nil))
                    return
                }
                
                if response.statusCode! != 200 {
                    self.updatePromise.failure(NSError(domain: "Update expense failed?", code: response.statusCode!, userInfo: nil))
                    return
                }
                
                print(response.description)
                let expense = Expense(JSONDecoder(response.data))
                self.updatePromise.success(expense)
            }
        } catch {
            self.updatePromise.failure(NSError(domain: "Request Error", code: 500, userInfo: nil))
        }
        return updatePromise.future
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


