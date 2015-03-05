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
    var groupPanelView:GroupPanelViewController!
    
    override func viewDidLoad(){
        bannerView = BannerViewController()
        bannerView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        profileView = ProfileViewController()
        profileView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        groupPanelView = GroupPanelViewController()
        groupPanelView.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.addChildViewController(bannerView)
        self.addChildViewController(profileView)
        self.addChildViewController(groupPanelView)
        
        
    }
    
    
    
    
}
