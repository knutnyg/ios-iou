//
//  SettingsViewController.swift
//  iou
//
//  Created by Knut Nygaard on 19/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var logOutButton:UIButton!
    var selectProfileImageButton:UIButton!
    var delegate:UIViewController!
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        selectProfileImageButton = createButton("Upload Photo", font: UIFont(name: "HelveticaNeue",size: 28)!)
        selectProfileImageButton.addTarget(self, action: "uploadPhotoPressed:", forControlEvents: .TouchUpInside)
        
        logOutButton = createButton("Log Out", font: UIFont(name: "HelveticaNeue",size: 28)!)
        logOutButton.addTarget(self, action: "logOutPressed:", forControlEvents: .TouchUpInside)
        
        let views = ["logOutButton":logOutButton, "uploadPhotoButton":selectProfileImageButton]
        
        view.addSubview(logOutButton)
        view.addSubview(selectProfileImageButton)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[uploadPhotoButton(40)]-50-[logOutButton(40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: logOutButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: selectProfileImageButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
    }
    
    func uploadPhotoPressed(sender:UIButton){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func logOutPressed(sender:UIButton){

        NSUserDefaults.standardUserDefaults().setValue("", forKey: "DefaultAccessToken")
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let scaledImage = ImageUtils.scaleImage(image, height: 200, width: 200)
        
        API.uploadImageForUser(scaledImage).onSuccess{response in
                print("Success!")
            }
            .onFailure{error in
                print("failure!")
            }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}