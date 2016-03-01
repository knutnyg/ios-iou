//
// Created by Knut Nygaard on 01/03/16.
// Copyright (c) 2016 APM solutions. All rights reserved.
//

import Foundation

func loadConfig() -> NSDictionary? {
    if let path = NSBundle.mainBundle().pathForResource("config", ofType: "plist") {
        return NSDictionary(contentsOfFile: path)
    } else {
        print("ERROR: Missing config file!")
        return nil
    }
}