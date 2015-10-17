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
        user = User(name: "Knut Nygaard", shortName: "Knut", id: 3, photoUrl: "https://lh3.googleusercontent.com/-f-ipeFeTcOo/AAAAAAAAAAI/AAAAAAAAAEw/C_qopDlJom4/photo.jpg?sz=50", email:"knutnyg@gmail.com")
        users = [user]
        group = Group(members: users, id: 26, archived: false, created: NSDate(), description: "IOS", lastUpdated: NSDate(), creator: user)
    }
    
    func testToJSONparseableDictionaryTest(){
        let result = group.toJSONparsableDicitonary()
        print(result)
        
    }
}