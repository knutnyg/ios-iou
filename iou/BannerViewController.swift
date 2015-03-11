//
//  bannerViewController.swift
//  iou
//
//  Created by Knut Nygaard on 3/5/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class BannerViewController : UIViewController {
    
    var backButton:UIButton!
    
    override func viewDidLoad() {
        
        backButton = createfontAwesomeButton("<")
        backButton.addTarget(self, action: "backPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backButton)
        
        view.backgroundColor = UIColor.redColor()
        
        let butLeft = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[but]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["but":backButton])
        
        let butTop = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-3-[but]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["but":backButton])
        
        self.view.addConstraints(butLeft)
        self.view.addConstraints(butTop)
        
    }
    
    func createfontAwesomeButton(unicode:String) -> UIButton{
        var button = UIButton()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle(unicode, forState: .Normal)
        button.titleLabel!.font = UIFont(name: "Verdana", size: 22)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        return button
    }
    
    func backPressed(sender:UIButton!) {
        println("sending backpressed")
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "backPressed", object: nil))
    }
}