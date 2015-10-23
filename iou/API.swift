
import Foundation
import BrightFutures

class API {
    static var accessToken:String?
    static var currentUser:User?
    
    static func defaultLogIn(username:String, password:String) -> Future<String,NSError>{
        return LogInHandler().logInWithDefault(username, password: password)
    }
    
    static func getUser() -> Future<User,NSError>{
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return UserHandler().getUser(token)
    }

    static func searchUsers(query:String) -> Future<[User],NSError>{
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return UserHandler().searchUser(token, query: query)
    }
    
    static func getGroupsForUser() -> Future<[Group],NSError> {
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return GroupHandler().getGroupsForUser(token)
    }
    
    static func createGroup(group:Group) -> Future<Group, NSError> {
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return GroupHandler().createGroup(token, group: group)

    }
    
    static func putGroup(group:Group) -> Future<Group, NSError> {
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return GroupHandler().putGroup(token, group: group)
    }
    
    static func getAllGroupData(group:Group) -> Future<Group, NSError> {
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return GroupHandler().getGroup(token, group: group)
    }
    
    static func getExpensesFromGroup(group:Group) -> Future<[Expense],NSError>{
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return ExpensesHandler().getExpensesForGroup(token, group: group)
    }
    
    static func putExpense(expense:Expense) -> Future<Expense,NSError>{
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return ExpensesHandler().updateExpense(token, expense: expense)
    }
    
    static func newExpense(expense:Expense) -> Future<Expense,NSError>{
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return ExpensesHandler().newExpense(token, expense: expense)
    }
    
    
    
    
    
    
    
    
}