//
//  ForgotPasswordViewController.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController {
    
    var emailTextField:UITextField!
    var submitButton:UIButton!
    var delegate:UIViewController!
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        emailTextField = createTextField("email")
        submitButton = createButton("Submit", font: UIFont(name: "HelveticaNeue",size: 28)!)
        submitButton.addTarget(self, action: "submitPressed:", forControlEvents: .TouchUpInside)
        
        let views = ["emailTextField":emailTextField, "submitButton":submitButton]
        
        view.addSubview(emailTextField)
        view.addSubview(submitButton)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[emailTextField(60)]-40-[submitButton(40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[emailTextField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: submitButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: submitButton, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
    }
    
    func submitPressed(sender:UIButton){
        ResetPasswordHandler().resetPassword(emailTextField.text!)
            .onSuccess { success in
                let alertController = UIAlertController(title: "", message:
                    "Please check your email", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            .onFailure{ error in
                let alertController = UIAlertController(title: "", message:
                    "Error: Check email and try again", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
    }
}