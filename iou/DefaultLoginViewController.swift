//
//  LoginViewController.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class DefaultLoginViewController: UIViewController {
    
    var forgotPasswordButton:UIButton!
    var signInButton:UIButton!
    var usernameTextField:UITextField!
    var passwordTextField:UITextField!
    var delegate:LoginViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = UIColor.whiteColor()
        
        setupNavigationBar()
        forgotPasswordButton = createButton("Forgot password")
        signInButton = createButton("Sign in!")
        
        usernameTextField = createTextField("username")
        passwordTextField = createTextField("password")
        passwordTextField.secureTextEntry = true
        
        forgotPasswordButton.addTarget(self, action: "forgotPasswordButtonPressed:", forControlEvents: .TouchUpInside)
        signInButton.addTarget(self, action: "signInButtonPressed:", forControlEvents: .TouchUpInside)
        
        let views = ["forgotPasswordButton":forgotPasswordButton, "signInButton":signInButton, "usernameTextField":usernameTextField,"passwordTextField":passwordTextField]

        view.addSubview(forgotPasswordButton)
        view.addSubview(signInButton)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[usernameTextField(60)]-40-[passwordTextField(60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[passwordTextField(60)]-40-[signInButton(60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[passwordTextField(60)]-40-[forgotPasswordButton(60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[usernameTextField]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[passwordTextField]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[signInButton]-20-[forgotPasswordButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: signInButton, attribute: .Width, relatedBy: .Equal, toItem: forgotPasswordButton, attribute: .Width, multiplier: 1, constant: 0))
    }
    
    func signInButtonPressed(sender:UIButton){
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        guard let un = username, let pw = password else {
            return
        }
        
        API.defaultLogIn(un, password: pw)
            .onSuccess{ token in
                
                API.accessToken = token
                
                //Store key to disk:
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setValue(token, forKey: "DefaultAccessToken")
                defaults.synchronize()
                
                let vc = MainViewController()
                vc.delegate = self
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .onFailure{ error in
        
            }
    }
    
    func forgotPasswordButtonPressed(sender:UIButton){
        let vc = ForgotPasswordViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor(netHex: 0x19B5FE)
        
        let font = UIFont(name: "Verdana", size:22)!
        let attributes:[String : AnyObject] = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationItem.title = "Log In"
        navigationController!.navigationBar.titleTextAttributes = attributes
        
        let verticalOffset = 1.5 as CGFloat;
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(verticalOffset, forBarMetrics: UIBarMetrics.Default)
    }    
}
