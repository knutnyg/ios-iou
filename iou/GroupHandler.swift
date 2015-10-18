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
    
    func getGroupsForUser(user:ActiveUser) -> Future<[Group],NSError> {
        
        promiseGroupsForUser = Promise<[Group], NSError>()

        guard let token = user.accessToken else {
            // Value requirements not met, do something
            //TODO: Redirect to login / Cast exception
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        
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
                let groupList = GroupList(JSONDecoder(response.data))
                
                self.promiseGroupsForUser.success(groupList.groups)
            }
            
        } catch {
            print("GroupHandler: got error in getGroupForUser")
            self.promiseGroupsForUser.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
        }
        
        return promiseGroupsForUser.future
    }
    
    func createGroup(user:ActiveUser,group:Group) -> Future<Group,NSError>{
        promiseCreateGroup = Promise<Group, NSError>()
        
        guard let token = user.accessToken else {
            // Value requirements not met, do something
            //Redirect to login
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        
        let url:String = "https://www.logisk.org/api/spreadsheets"
        let payload:[String:AnyObject] = ["description":group.description, "creator":group.creator.toJSONParseableDictionary()]

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
    
    func editGroup(user:ActiveUser,group:Group) -> Future<Group,NSError>{
        promiseEditGroup = Promise<Group, NSError>()
        guard let token = user.accessToken else {
            // Value requirements not met, do something
            //Redirect to login
            return Future(error: NSError(domain: "NOT_AUTHENTICATED", code: 403, userInfo: nil))
        }
        
        let url:String = "https://www.logisk.org/api/spreadsheets/\(group.id)"
        let payload:[String:AnyObject] = group.toJSONparsableDicitonary()
        
        do {
            let request = try HTTP.PUT(url, parameters: payload, headers: ["AccessToken":token], requestSerializer: JSONParameterSerializer())
            
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
    
    func archiveGroup(group:Group){
        
    }
    
    func addMember(user:User){
        
    }
}


