//
//  SummaryViewController.swift
//  iou
//
//  Created by Knut Nygaard on 04/04/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class SummaryViewController : UIViewController {
    
    override func viewDidLoad() {
        
        var aImage = readResponseFromFile()
        var iw = UIImageView(image: aImage)
        iw.setTranslatesAutoresizingMaskIntoConstraints(false)
        iw.layer.cornerRadius = 25
        iw.clipsToBounds = true
        self.view.addSubview(iw)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[image(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["image":iw]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[image(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["image":iw]))
    }
    
    
    func readResponseFromFile() -> UIImage{
        let path = NSBundle.mainBundle().pathForResource("image", ofType: "png")
        var data = NSData(contentsOfFile: path!)!
        //        var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        return UIImage(data: data)!
    }
}