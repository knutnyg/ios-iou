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


class GroupHandler {
    
    var promiseGroupsForUser:Promise<[Group],NSError>!
    var promiseCreateGroup:Promise<Group,NSError>!
    var promiseEditGroup:Promise<Group,NSError>!
    var promiseGetGroup:Promise<Group,NSError>!
    
    func getGroupsForUser(token:String) -> Future<[Group],NSError> {
        
        promiseGroupsForUser = Promise<[Group], NSError>()
        
        let url:String = "https://www.logisk.org/api/spreadsheets"
        do {
            let request = try HTTP.GET(url, headers: ["AccessToken":token], requestSerializer:JSONParameterSerializer())
            
            request.start { response in
                if let err = response.error {
                    print("GroupHandler: Response contains error: \(err)")
                    self.promiseGroupsForUser.failure(err)
                    return
                }
                print("Debug: GroupHandler got response")
                print(response.description)
                let groupList = GroupList(JSONDecoder(response.data))
                let sortedGroup = groupList.groups.sort({ $0.lastUpdated.timeIntervalSinceNow > $1.lastUpdated.timeIntervalSinceNow })
                self.promiseGroupsForUser.success(sortedGroup)
            }
            
        } catch {
            print("GroupHandler: got error in getGroupForUser")
            self.promiseGroupsForUser.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        
        return promiseGroupsForUser.future
    }
    
    func createGroup(token:String, name:String, creator:User) -> Future<Group,NSError>{
        promiseCreateGroup = Promise<Group, NSError>()
        
        let url:String = "https://www.logisk.org/api/spreadsheets"
        let payload:[String:AnyObject] = ["description":name, "creator":creator.toJSONParseableDictionary()]

        do {
            let request = try HTTP.POST(url, parameters: payload, headers: ["AccessToken":token], requestSerializer: JSONParameterSerializer())
            
            print(request.description)
            
            request.start { response in
                if let err = response.error {
                    print("GroupHandler: Response contains error: \(err)")
                    self.promiseCreateGroup.failure(err)
                    return
                }
                print("Debug: GroupHandler got response")
                print(response.description)
                let group = Group(JSONDecoder(response.data))
                
                self.promiseCreateGroup.success(group)
            }
            
        } catch {
            print("GroupHandler: got error in getGroupForUser")
            self.promiseCreateGroup.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        
        return promiseCreateGroup.future
    }
    
    func putGroup(token:String,group:Group) -> Future<Group,NSError>{
        promiseEditGroup = Promise<Group, NSError>()
        
        let url:String = "https://www.logisk.org/api/spreadsheets/\(group.id)"
        var payload:[String:AnyObject] = group.toJSONparsableDicitonary()

        do {
            let request = try HTTP.PUT(url, parameters: payload, headers: ["AccessToken":token], requestSerializer: JSONParameterSerializer())

            print(payload)

            request.start { response in
                if let err = response.error {
                    print("GroupHandler: Response contains error: \(err)")
                    self.promiseEditGroup.failure(err)
                    return
                } else if response.statusCode != 200 {
                    self.promiseEditGroup.failure(NSError(domain: "Wrong HTTPCODE", code: response.statusCode!, userInfo: nil))
                    return
                }
                print("Debug: GroupHandler got response")
                print(response.description)
                let group = Group(JSONDecoder(response.data))
                
                self.promiseEditGroup.success(group)
            }
            
        } catch {
            print("GroupHandler: got error in getGroupForUser")
            self.promiseEditGroup.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        return promiseEditGroup.future
    }
    
    func getGroup(token:String, group:Group) -> Future<Group,NSError> {
        promiseGetGroup = Promise<Group, NSError>()

        let url: String = "https://www.logisk.org/api/spreadsheets/\(group.id)"

        do {
            let request = try HTTP.GET(url, headers: ["AccessToken": token], requestSerializer: JSONParameterSerializer())

            request.start {
                response in
                if let err = response.error {
                    print("GroupHandler: Response contains error: \(err)")
                    self.promiseGetGroup.failure(err)
                    return
                } else if response.statusCode != 200 {
                    self.promiseGetGroup.failure(NSError(domain: "Wrong HTTPCODE", code: response.statusCode!, userInfo: nil))
                    return
                }
                print("Debug: GroupHandler got response")
                print(response.description)
                let group = Group(JSONDecoder(response.data))
                group.expenses = group.expenses.sort({ $0.date.timeIntervalSinceNow > $1.date.timeIntervalSinceNow })
                self.promiseGetGroup.success(group)
            }

        } catch {
            print("GroupHandler: got error in getGroupForUser")
            self.promiseEditGroup.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        return promiseGetGroup.future
    }
}


