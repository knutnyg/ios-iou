//
//  SummaryViewController.swift
//  iou
//
//  Created by Knut Nygaard on 04/04/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class SummaryViewController:UIViewController {
    
//    var group:Group
    var summary:[SummaryItem]!
    
    override func viewDidLoad() {
        
        summary = []
        createMockSummary(5)
        layOutConstraints()
        addBorderBasedOnStatus()
    }
    
    
    func readResponseFromFile() -> UIImage{
        var path = NSBundle.mainBundle().pathForResource("image", ofType: "png")
        var data = NSData(contentsOfFile: path!)!
        //        var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        return UIImage(data: data)!
    }
    
    func addBorderBasedOnStatus(){
        
        for item in self.summary {
            var baseColor = setBaseColor(item)
            var color = setAlphaColor(baseColor, item: item)
            println(CGColorGetAlpha(color.CGColor))
            item.imageView.layer.borderWidth = 3.0
            item.imageView.layer.borderColor = color.CGColor
        }
    }
    
    
    func setBaseColor(item:SummaryItem) -> UIColor{
        if item.amount < 0 {
            return UIColor.redColor()
        } else if item.amount > 0 {
            return UIColor.greenColor()
        } else {
            return UIColor.whiteColor()
        }
    }
    
    func setAlphaColor(color:UIColor, item:SummaryItem) -> UIColor{
        if abs(item.amount) > 1000 {
            return color
        } else {
            var strenght = abs(item.amount).CGFloatValue  / 1000.0
            return color.colorWithAlphaComponent(strenght)
        }
    }
    
    func layOutConstraints (){
        
        var views = createViews()
        
        for i in 0...summary.count-1 {

            //first image
            self.view.addSubview(summary[i].imageView)
            if i == 0 {
                self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[image\(i)(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
                self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[image\(i)(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
            } else if i % 4 == 0 {
                self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[image\(i)(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
                self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[image\(i-4)]-10-[image\(i)(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
            } else {
                self.view.addConstraint(NSLayoutConstraint(item: summary[i].imageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: summary[i-1].imageView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 60))
                self.view.addConstraint(NSLayoutConstraint(item: summary[i].imageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: summary[i-1].imageView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
                self.view.addConstraint(NSLayoutConstraint(item: summary[i].imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 50))
                self.view.addConstraint(NSLayoutConstraint(item: summary[i].imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 50))
            }
        }
    }
    
    func createViews() -> [NSObject : AnyObject]{
        var views:[NSObject : AnyObject] = [:]
        for i in 0...summary.count-1 {
            views["image\(i)"] = summary[i].imageView
        }
        
        return views
    }
    
    func createImage() -> UIImageView {
        
        var image = readResponseFromFile()
        var iw = UIImageView(image: image)
        iw.setTranslatesAutoresizingMaskIntoConstraints(false)
        iw.layer.cornerRadius = 25
        iw.clipsToBounds = true
        
        return iw

    }
    
    func createMockSummary(count:Int) {
        
        var userList = createMockUsers(count)
        for user in userList {
            var imageView = createImage()
            var amount = Double(arc4random_uniform(2000)) - 1000
            var summaryItem = SummaryItem(imageView: imageView, user: user, amount: amount)
            summary.append(summaryItem)
            println("made row with values: \(summaryItem.user.name), \(summaryItem.amount)")
        }
    }
    
    func createMockUsers(count:Int) -> [User]{
        var user = User(name: "Knut Nygaard", shortName: "Knut", id: 1, photoUrl: "url")
        var userList:[User] = []
        for i in 0...count-1 {
            userList.append(user)
        }
        
        return userList
        
    }
}

extension Double {
    var CGFloatValue: CGFloat {
        get {
            return CGFloat(self)
        }
    }
}
extension Int {
    var CGFloatValue: CGFloat {
        get {
            return CGFloat(self)
        }
    }
}