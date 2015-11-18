//
//  GroupModelTests.swift
//  iou
//
//  Created by Knut Nygaard on 17/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import XCTest

class GroupTests : XCTestCase {
    
    var user:User!
    var group:Group!
    var users:[User]!
    
    override func setUp() {
        user = User(name: "Knut Nygaard", shortName: "Knut", id: "1af102d9-c224-451b-b793-7a239af09807", photoUrl: "https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50", email:"knutnyg@gmail.com")
        users = [user]
        group = Group(members: users, id: "an_id", archived: false, created: NSDate(), description: "IOS", lastUpdated: NSDate(), creator: user, expenses: [])
    }
    
    func testToJSONparseableDictionaryTest(){
        let result = group.toJSONparsableDicitonary()
        print(result)
        
    }
}