//
// Created by Knut Nygaard on 01/03/16.
// Copyright (c) 2016 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class TestBase : XCTestCase {

    var token:String!
    var user:User!
    var group:Group!

    override init(invocation inv:Foundation.NSInvocation?){
        super.init(invocation: inv)
        API.baseUrl = "https://dev.logisk.org"
        token = "eyJpZCI6ImE2YzljNTkzLTI1YjEtNDEwMC05ZjE0LWRlNmMxYjQ2YTJlNCIsInRva2VuX2lkIjoiIiwiZW1haWwiOiJrbnV0bnlnK3Rlc3RAZ21haWwuY29tIiwibmFtZSI6IktudXQiLCJzaG9ydG5hbWUiOiIiLCJwaG90b3VybCI6Imh0dHBzOi8vd3d3LmxvZ2lzay5vcmcvYXBpL3VzZXJzL3Bob3RvL2E2YzljNTkzLTI1YjEtNDEwMC05ZjE0LWRlNmMxYjQ2YTJlNCIsInNlY3JldCI6IjYxMzY4ZDQ0Y2JkM2U1YTU4YmIyM2VjYTNkZTU2MDhlMTI2N2IyMWZlNjdlOTg3MTE4M2Y2MmNhNjc2YmEyYTEiLCJjcmVhdGVkX2F0IjoiMjAxNi0wMy0wMVQxMjo0NTo0Ni40NzYzNjA4NTdaIn0="
        user = User(name: "Knut", shortName: "Knut", id: "a6c9c593-25b1-4100-9f14-de6c1b46a2e4", photoUrl: "https://www.logisk.org/api/users/photo/a6c9c593-25b1-4100-9f14-de6c1b46a2e4", email: "knutnyg+test@gmail.com")
        group = Group(members: [user], id: "c1d3c321-e773-40a5-ad54-70ce2d2199c6", archived: false, created: NSDate(), description: "Test", lastUpdated: NSDate(), creator: user, expenses: [])
    }
}
