
import Foundation
import BrightFutures
import SwiftyJSON
import SwiftHTTP
import JSONJoy

class ExpensesHandler {
    
    static func getExpensesForGroup(token:String, group:Group) -> Future<[Expense],NSError> {
        
        let promise = Promise<[Expense], NSError>()
        
        let url:String = "\(API.baseUrl)/api/spreadsheets/\(group.id)/receipts"
        do {
            let request = try HTTP.GET(url, headers: ["AccessToken":token], requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("ExpensesListFetcher: Response contains error: \(err)")
                    promise.failure(err)
                    return
                }
                print("Debug: ExpensesListFetcher got response")
                
                let expenseList = ExpenseList(JSONDecoder(response.data))
                print(response.description)
                for expense:Expense in expenseList.expenses {
                    self.populateCreatorIfNotSet(expense, members: group.members)
                }

                promise.success(expenseList.expenses)
            }
            
        } catch {
            print("ExpensesListFetcher: got error in getExpensesForGroup")
            promise.failure(NSError(domain: "SSL", code: 503, userInfo: nil))
        }
        
        return promise.future
    }
    
    static func updateExpense(token:String, expense:Expense) -> Future<Expense,NSError>{
        
        let updatePromise = Promise<Expense,NSError>()
        
        let urlString = "\(API.baseUrl)/api/spreadsheets/\(expense.groupId)/receipts/\(expense.id)"
        
        let payload:[String:AnyObject] = expense.toJSONparsableDicitonary() as! [String : AnyObject]
        do {
            let request = try HTTP.PUT(urlString, parameters: payload, headers: ["AccessToken":token], requestSerializer: JSONParameterSerializer())
            request.start { response in
                if let err = response.error {
                    print("ExpensesListFetcher-updateExpense: Response contains error: \(err)")
                    updatePromise.failure(NSError(domain: "Update expense", code: response.statusCode!, userInfo: nil))
                    return
                }
                
                if response.statusCode! != 200 {
                    updatePromise.failure(NSError(domain: "Update expense failed?", code: response.statusCode!, userInfo: nil))
                    return
                }
                
                print("---- UPDATE EXPENSE RESPONSE ----\n" + response.description)
                let expense = Expense(JSONDecoder(response.data))
                updatePromise.success(expense)
            }
        } catch {
            updatePromise.failure(NSError(domain: "Request Error", code: 500, userInfo: nil))
        }
        return updatePromise.future
    }
    
    static func newExpense(token:String, expense:Expense) -> Future<Expense,NSError>{
        
        let updatePromise = Promise<Expense,NSError>()

        if expense.participants.count == 0 {
            return Future(error: NSError(domain: "Participants cannot be 0", code: 500, userInfo: nil))
        }
        
        let urlString = "\(API.baseUrl)/api/spreadsheets/\(expense.groupId)/receipts"
        
        let payload:[String:AnyObject] = expense.toJSONCreate() as! [String : AnyObject]
        do {
            let request = try HTTP.POST(urlString, parameters: payload, headers: ["AccessToken":token], requestSerializer: JSONParameterSerializer())
            request.start { response in
                if let err = response.error {
                    print("ExpensesListFetcher-updateExpense: Response contains error: \(err)")
                    updatePromise.failure(NSError(domain: "New expense failed", code: response.statusCode!, userInfo: nil))
                    return
                }
                
                if response.statusCode! != 201 {
                    updatePromise.failure(NSError(domain: "New expense failed?", code: response.statusCode!, userInfo: nil))
                    return
                }
                
                print(response.description)
                let expense = Expense(JSONDecoder(response.data))
                updatePromise.success(expense)
            }
        } catch {
            updatePromise.failure(NSError(domain: "Request Error", code: 500, userInfo: nil))
        }
        return updatePromise.future
    }

    static func deleteExpense(token:String, expense:Expense) -> Future<Expense, NSError>{

        let deletePromise = Promise<Expense,NSError>()

        let urlString = "\(API.baseUrl)/api/spreadsheets/\(expense.groupId)/receipts/\(expense.id)"
        print(urlString)

        do {
            let request = try HTTP.DELETE(urlString, headers: ["AccessToken":token], requestSerializer: JSONParameterSerializer())
            request.start { response in

                print(response.description)

                if let err = response.error {
                    print("ExpensesHandler-deleteExpense: Response contains error: \(err)")
                    deletePromise.failure(NSError(domain: "Delete expense failed", code: response.statusCode!, userInfo: nil))
                    return
                }

                if (response.statusCode! == 200 || response.statusCode! == 204)  {
                    deletePromise.success(expense)
                    return
                }

                deletePromise.failure(NSError(domain: "Delete expense failed", code: response.statusCode!, userInfo: nil))
                return
            }
        } catch {
            deletePromise.failure(NSError(domain: "Request Error", code: 500, userInfo: nil))
        }
        return deletePromise.future
    }


    static func populateCreatorIfNotSet(expense:Expense, members:[User]){
        if expense.creator.name == nil{
            if let user = findUserById(expense.creator.id, members: members) {
                expense.creator = user
            }
        }
    }
    
    static func findUserById(id:String, members:[User]) -> User?{
        for user in members {
            if user.id == id {
                return user
            }
        }
        return nil
    }
}


