//
//  CommonComponents.swift
//  iou
//
//  Created by Knut Nygaard on 18/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

func createTextField(placeholder:String) -> UITextField {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = placeholder
    textField.borderStyle = UITextBorderStyle.RoundedRect
    textField.textAlignment = NSTextAlignment.Center
    textField.keyboardType = UIKeyboardType.EmailAddress
    textField.returnKeyType = UIReturnKeyType.Done
    
    return textField
}

func createButton(text:String) -> UIButton {
    let button = UIButton(type: UIButtonType.System)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, forState: UIControlState.Normal)
    button.layer.borderWidth = 1.0
    return button
}
