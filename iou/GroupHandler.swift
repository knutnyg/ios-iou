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

    static func getGroupsForUser(token: String) -> Future<[Group], NSError> {

        let promiseGroupsForUser = Promise<[Group], NSError>()

        let url: String = "https://www.logisk.org/api/spreadsheets"
        do {
            let request = try HTTP.GET(url, headers: ["AccessToken": token], requestSerializer: JSONParameterSerializer())

            request.start {
                response in
                if let err = response.error {
                    print("GroupHandler: Response contains error: \(err)")
                    promiseGroupsForUser.failure(err)
                    return
                }
                print("Debug: GroupHandler got response")
                print(response.description)
                let groupList = GroupList(JSONDecoder(response.data))
                let sortedGroups = groupList.groups

            var newSortedGroups: [Group] = []
            for group: Group in sortedGroups {
                let sortedMembers = group.members.sort({ $0.name < $1.name })
                var g = group
                g.members = sortedMembers
                newSortedGroups.append(g)
            }

            promiseGroupsForUser.success(newSortedGroups)
            }

            } catch {
                print("GroupHandler: got error in getGroupForUser")
                promiseGroupsForUser.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
            }

        return promiseGroupsForUser.future
        }

static func createGroup(token: String, name: String, creator: User) -> Future<Group, NSError> {
    let promiseCreateGroup = Promise<Group, NSError>()

    let url: String = "https://www.logisk.org/api/spreadsheets"
    let payload: [String:AnyObject] = ["description": name, "creator": creator.toJSONParseableDictionary()]

    do {
        let request = try HTTP.POST(url, parameters: payload, headers: ["AccessToken": token], requestSerializer: JSONParameterSerializer())

        print(request.description)

        request.start {
            response in
            if let err = response.error {
                print("GroupHandler: Response contains error: \(err)")
                promiseCreateGroup.failure(err)
                return
            }
            print("Debug: GroupHandler got response")
            print(response.description)
            let group = Group(JSONDecoder(response.data))

            promiseCreateGroup.success(group)
        }

    } catch {
        print("GroupHandler: got error in getGroupForUser")
        promiseCreateGroup.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
    }

    return promiseCreateGroup.future
}

static func putGroup(token: String, group: Group) -> Future<Group, NSError> {
    let promiseEditGroup = Promise<Group, NSError>()

    let url: String = "https://www.logisk.org/api/spreadsheets/\(group.id)"
    let payload: [String:AnyObject] = group.toJSONparsableDicitonary()

    do {
        let request = try HTTP.PUT(url, parameters: payload, headers: ["AccessToken": token], requestSerializer: JSONParameterSerializer())

        print(payload)

        request.start {
            response in
            if let err = response.error {
                print("GroupHandler: Response contains error: \(err)")
                promiseEditGroup.failure(err)
                return
            } else if response.statusCode != 200 {
                promiseEditGroup.failure(NSError(domain: "Wrong HTTPCODE", code: response.statusCode!, userInfo: nil))
                return
            }
            print("Debug: GroupHandler got response")
            print(response.description)
            let group = Group(JSONDecoder(response.data))

            promiseEditGroup.success(group)
        }

    } catch {
        print("GroupHandler: got error in getGroupForUser")
        promiseEditGroup.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
    }
    return promiseEditGroup.future
}

static func getGroup(token: String, group: Group) -> Future<Group, NSError> {
    let promiseGetGroup = Promise<Group, NSError>()

    let url: String = "https://www.logisk.org/api/spreadsheets/\(group.id)"
    let payload: [String:AnyObject] = group.toJSONparsableDicitonary()

    do {
        let request = try HTTP.GET(url, parameters: payload, headers: ["AccessToken": token], requestSerializer: JSONParameterSerializer())

        request.start {
            response in
            if let err = response.error {
                print("GroupHandler: Response contains error: \(err)")
                promiseGetGroup.failure(err)
                return
            } else if response.statusCode != 200 {
                promiseGetGroup.failure(NSError(domain: "Wrong HTTPCODE", code: response.statusCode!, userInfo: nil))
                return
            }
            print("Debug: GroupHandler got response")
            print(response.description)
            let group = Group(JSONDecoder(response.data))
            group.expenses = group.expenses.sort({
                if let d1 = $0.date, d2 = $1.date {
                    return d1.timeIntervalSinceNow > d2.timeIntervalSinceNow
                } else {
                    return false
                }
            })
            group.members = group.members.sort({ $0.name < $1.name })
            promiseGetGroup.success(group)
        }

    } catch {
        print("GroupHandler: got error in getGroupForUser")
        promiseGetGroup.failure(NSError(domain: "SSL", code: 200, userInfo: nil))
    }
    return promiseGetGroup.future
}

}


