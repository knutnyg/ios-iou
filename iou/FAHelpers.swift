//
//  FAHelpers.swift
//  iou
//
//  Created by Knut Nygaard on 4/29/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation


func createfontAwesomeButton(unicode:String) -> UIButton{
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(unicode, forState: .Normal)
    button.titleLabel!.font = UIFont(name: "Verdana", size: 22)
    button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    button.setTitleColor(UIColor.redColor(), forState: .Highlighted)
    return button
}