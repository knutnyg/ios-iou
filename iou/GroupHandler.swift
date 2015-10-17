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
    
     var accessToken = "eyJpZCI6MywiZW1haWwiOiJrbnV0bnlnQGdtYWlsLmNvbSIsIm5hbWUiOiJLbnV0IE55Z2FhcmQiLCJzaG9ydG5hbWUiOiJLbnV0IiwicGhvdG91cmwiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLWYtaXBlRmVUY09vL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUV3L0NfcW9wRGxKb200L3Bob3RvLmpwZz9zej01MCIsInNlY3JldCI6IjJhN2U2ZGUzOGFiMDBiYmVmNTNhYzQxOGY3MmFiNGVjNDM1MzVkZmI0NDYyZTZiNjRkOWI0MWI4YWI4OGFmMGIiLCJjcmVhdGVkX2F0IjoiMjAxNS0wNC0wMlQwNTozMTowMy4zNTc0MjMxNFoifQ=="
    
    func getGroupsForUser() -> Future<[Group],NSError> {
        
        promiseGroupsForUser = Promise<[Group], NSError>()

        let url:String = "https://www.logisk.org/api/spreadsheets"
        do {
            let request = try HTTP.GET(url, headers: ["AccessToken":accessToken], requestSerializer:JSONParameterSerializer())
            
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
    
    func createGroup(group:Group) -> Future<Group,NSError>{
        promiseCreateGroup = Promise<Group, NSError>()
        
        let url:String = "https://www.logisk.org/api/spreadsheets"
        let payload:[String:AnyObject] = ["description":group.description, "creator":group.creator.toJSONParseableDictionary()]

        do {
            let request = try HTTP.POST(url, parameters: payload, headers: ["AccessToken":accessToken], requestSerializer: JSONParameterSerializer())
            
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
    
    func editGroup(group:Group) -> Future<Group,NSError>{
        promiseEditGroup = Promise<Group, NSError>()
        
        let url:String = "https://www.logisk.org/api/spreadsheets/\(group.id)"
        let payload:[String:AnyObject] = group.toJSONparsableDicitonary()
        
        do {
            let request = try HTTP.PUT(url, parameters: payload, headers: ["AccessToken":accessToken], requestSerializer: JSONParameterSerializer())
            
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


