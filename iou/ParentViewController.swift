//
//  parentViewController.swift
//  iou
//
//  Created by Knut Nygaard on 3/5/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class ParentViewController : UIViewController {
    
    var bannerView:BannerViewController!
    var profileView:ProfileViewController!
    var groupPanelView:GroupListPanel!
    var label:UILabel!
    
    override func viewDidLoad(){
        bannerView = BannerViewController()
        bannerView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        profileView = ProfileViewController()
        profileView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        groupPanelView = GroupListPanel()
        groupPanelView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "tonaowda"
        label.backgroundColor = UIColor.blueColor()
        
        self.addChildViewController(bannerView)
        self.addChildViewController(profileView)
        self.addChildViewController(groupPanelView)
        
        view.addSubview(bannerView.view)
        view.addSubview(profileView.view)
        view.addSubview(groupPanelView.view)
        view.addSubview(label)
        
        let views:[NSObject : AnyObject] = ["topBanner":bannerView.view,"profile":profileView.view,"groupPanel":groupPanelView.view, "label":label]
        
        setChildviewConstraints(views)
    }
    
    func setChildviewConstraints(views:[NSObject:AnyObject]){
        let screenHeight = view.frame.height
        println(screenHeight)
        
        switch screenHeight {
//            case 480: setupForiPhoneFour(views)
//            case 568: setupForiPhoneFive(views)
            case 667: setupForiPhoneSix(views)
            case 736: setupForiPhoneSix(views)
//            case 1024: setupForiPadTwo(views)
            default: println("default")
            }
        
        
    }
    func setupForiPhoneSix(views:[NSObject:AnyObject]) {
        let constraintModel = ParentViewConstraints(
            bannerHeight: 80,
            profileViewHeight: 150,
            groupViewHeight: 300,
            cellHeight: 30
        )
        
        setConstraints(views, constraintsModel: constraintModel)
        
    }
    
    func setConstraints(views:[NSObject:AnyObject], constraintsModel:ParentViewConstraints){
        
        var visualFormat = String(format: "V:|-0-[topBanner(%d)]-0-[profile(%d)]-0-[groupPanel(%d)]-[label]",
            constraintsModel.bannerHeight,
            constraintsModel.profileViewHeight,
            constraintsModel.groupViewHeight
        )
        
        
        
        let verticalLayout = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        
        visualFormat = "H:|-0-[topBanner]-0-|"
        let bannerWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        
        visualFormat = "H:|-0-[profile]-0-|"
        let profileWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        
        visualFormat = "H:|-0-[groupPanel]-0-|"
        let groupPanelWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        
        visualFormat = "H:|-0-[label]-0-|"
        let buttonWidth = NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        
        view.addConstraints(verticalLayout)
        view.addConstraints(bannerWidth)
        view.addConstraints(profileWidth)
        view.addConstraints(groupPanelWidth)
        view.addConstraints(buttonWidth)
    }

    
    
    
}
