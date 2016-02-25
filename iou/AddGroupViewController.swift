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
        navigationItem.title = "Add group"

        addGroupTextField = createTextField("enter a group name")

        submitButton = createButton("Submit", font: UIFont(name: "HelveticaNeue",size: 28)!)
        submitButton.addTarget(self, action: "submitPressed:", forControlEvents: .TouchUpInside)

        view.addSubview(addGroupTextField)
        view.addSubview(submitButton)

        let rules = [
                ConstraintRules()
                    .snapRight(view.snp_right)
                    .snapLeft(view.snp_left)
                    .snapTop(view.snp_top)
                    .marginTop(100)
                    .marginLeft(8)
                    .marginRight(8)
                    .height(60),
                ConstraintRules()
                    .centerX()
                    .height(40)
                    .width(100)
                    .snapTop(addGroupTextField.snp_bottom)
        ]

        SnapKitHelpers.setConstraints(view, components: [addGroupTextField, submitButton], rules: rules)
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
