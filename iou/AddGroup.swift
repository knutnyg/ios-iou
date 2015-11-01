//
// Created by Knut Nygaard on 27/10/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class AddGroup : UIViewController {

    var addGroupTextField:UITextField!
    var submitButton:UIButton!

    override func viewDidLoad() {

        view.backgroundColor = UIColor.whiteColor()

        addGroupTextField = createTextField("enter a group name")
        submitButton = createButton("Submit", font: UIFont(name: "HelveticaNeue",size: 28)!)
        submitButton.addTarget(self, action: "submitPressed:", forControlEvents: .TouchUpInside)

        let views = ["addGroup":addGroupTextField, "submitButton":submitButton]

        view.addSubview(addGroupTextField)
        view.addSubview(submitButton)

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[addGroup(60)]-40-[submitButton(40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[addGroup]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: submitButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: submitButton, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
    }

    func submitPressed(sender:UIButton){
        if let user = API.currentUser {
            API.createGroup(addGroupTextField.text!, creator: user).onSuccess { group in
                self.navigationController?.popViewControllerAnimated(true)
            }
            .onFailure{ err in
                print(err)
            }
        }
    }
}
