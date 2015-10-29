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

func createButton(text:String, font:UIFont) -> UIButton {
    let button = UIButton(type: UIButtonType.System)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, forState: UIControlState.Normal)
    button.titleLabel!.font = font
    return button
}

func createButton(text:String) -> UIButton {
    let button = UIButton(type: UIButtonType.System)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, forState: UIControlState.Normal)
    return button
}

func createLabel(text:String) -> UILabel{
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = UIFont(name: "Helvetica", size: 18)
    return label
}

func createLabel(text:String, font:UIFont) -> UILabel{
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = font
    return label
}
