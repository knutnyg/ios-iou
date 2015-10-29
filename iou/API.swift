
import Foundation
import BrightFutures

class API {
    static var accessToken:String?
    static var currentUser:User?
    static var currentGroup:Group?
    static var currentExpense:Expense?
    static var currentLocale:NSLocale?
    
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
    
    static func createGroup(name:String, creator:User) -> Future<Group, NSError> {
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return GroupHandler().createGroup(token, name: name, creator: creator)

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

    static func deleteExpense(expense:Expense) -> Future<Expense,NSError>{
        guard let token = accessToken else {
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        return ExpensesHandler().deleteExpense(token, expense: expense)
    }
    
    
    
    
    
    
    
    
}