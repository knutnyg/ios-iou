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

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var facebookLoginButton:UIButton!
    var defaultLoginButton:UIButton!
    var signupButton:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        //Check if logged in:
        if let accessToken = NSUserDefaults.standardUserDefaults().stringForKey("DefaultAccessToken"){
            if !accessToken.isEmpty {
                //Skip login
                API.accessToken = accessToken
                let vc = MainViewController()
                vc.delegate = self
                
                self.navigationController?.pushViewController(vc, animated: false)
                
            }
        }

        
        
        setupNavigationBar()
        facebookLoginButton = createFacebookButton()
        defaultLoginButton = createButton("Log in without facebook")
        signupButton = createButton("Sign up")
        
        defaultLoginButton.addTarget(self, action: "defaultLoginPressed:", forControlEvents: .TouchUpInside)
        signupButton.addTarget(self, action: "signupButtonPressed:", forControlEvents: .TouchUpInside)
        
        let views = ["facebookButton":facebookLoginButton, "defaultLoginButton":defaultLoginButton, "signupButton":signupButton]
        
        view.addSubview(facebookLoginButton)
        view.addSubview(defaultLoginButton)
        view.addSubview(signupButton)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[facebookButton(40)]-40-[defaultLoginButton(40)]-80-[signupButton(40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[facebookButton]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[defaultLoginButton]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[signupButton]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
//        if (FBSDKAccessToken.currentAccessToken() == nil)
//        {
//            print("Not logged in..")
//        }
//        else
//        {
//            print("Logged in..")
//        }
        
        
    
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
            print("Login complete.")
            print(FBSDKAccessToken.currentAccessToken().tokenString)
            
            let vc = MainViewController()
            vc.delegate = self
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("User logged out...")
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor(netHex: 0x19B5FE)
        
        let font = UIFont(name: "Verdana", size:22)!
        let attributes:[String : AnyObject] = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationItem.title = "IOU"
        navigationController!.navigationBar.titleTextAttributes = attributes
        
        let verticalOffset = 1.5 as CGFloat;
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(verticalOffset, forBarMetrics: UIBarMetrics.Default)
    }
        
    func createFacebookButton() -> FBSDKButton{
        let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile", "email"]
        button.translatesAutoresizingMaskIntoConstraints = false
        button.delegate = self
        return button
    }
    
    func createButton(text:String) -> UIButton {
        let button = UIButton(type: UIButtonType.RoundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, forState: UIControlState.Normal)
        button.layer.borderWidth = 1.0
        return button
    }
    
    func defaultLoginPressed(sender:UIButton){
        let vc = DefaultLoginViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    
    
    
    
}
