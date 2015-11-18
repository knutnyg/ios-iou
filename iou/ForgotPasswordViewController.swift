//
//  ForgotPasswordViewController.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit
import SwiftValidator

class ForgotPasswordViewController: UIViewController, ValidationDelegate{
    
    var emailTextField:UITextField!
    var submitButton:UIButton!
    var delegate:UIViewController!
    var emailErrorLabel:UILabel!
    let validator = Validator()
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        emailTextField = createTextField("email")
        submitButton = createButton("Submit", font: UIFont(name: "HelveticaNeue",size: 28)!)
        submitButton.addTarget(self, action: "submitPressed:", forControlEvents: .TouchUpInside)

        emailErrorLabel = createLabel("")
        emailErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailErrorLabel)
        emailErrorLabel.hidden = true

        let views = ["emailTextField":emailTextField, "submitButton":submitButton, "emailErrorLabel":emailErrorLabel]
        
        view.addSubview(emailTextField)
        view.addSubview(submitButton)



        validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule(message: "Invalid email")])
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[emailTextField(60)]-40-[submitButton(40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[emailTextField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: submitButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: submitButton, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[emailErrorLabel]-[emailTextField]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[emailErrorLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    func submitPressed(sender:UIButton){
        clearValidationErrors()
        validator.validate(self)
    }

    func validationSuccessful() {

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

    func validationFailed(errors:[UITextField:ValidationError]) {
        // turn the fields to red
        for (field, error) in validator.errors {
            field.layer.borderColor = UIColor.redColor().CGColor
            field.layer.borderWidth = 1.0
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.hidden = false
        }
    }

    func clearValidationErrors(){
        emailTextField.layer.borderWidth = 0.0
        emailErrorLabel.hidden = true
    }
}