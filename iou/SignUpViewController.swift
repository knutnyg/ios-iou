//
// Created by Knut Nygaard on 15/11/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import SnapKit
import SwiftValidator

class SignUpViewController: UIViewController, ValidationDelegate {

    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var confirm_passwordTextField: UITextField!

    var submitButton: UIButton!

    var nameErrorLabel: UILabel!
    var emailErrorLabel: UILabel!
    var passwordErrorLabel: UILabel!
    var confirm_passwordErrorLabel: UILabel!
    var validator: Validator!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        validator = Validator()

        nameTextField = createTextField("name")
        emailTextField = createTextField("email")
        passwordTextField = createTextField("password")
        confirm_passwordTextField = createTextField("confirm password")
        submitButton = createButton("Submit")
        submitButton.addTarget(self, action: "submitPressed:", forControlEvents: .TouchUpInside)

        passwordTextField.secureTextEntry = true
        confirm_passwordTextField.secureTextEntry = true

        nameErrorLabel = createLabel("")
        emailErrorLabel = createLabel("")
        passwordErrorLabel = createLabel("")
        confirm_passwordErrorLabel = createLabel("")

        nameErrorLabel.hidden = true
        emailErrorLabel.hidden = true
        passwordErrorLabel.hidden = true
        confirm_passwordErrorLabel.hidden = true

        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirm_passwordTextField)
        view.addSubview(submitButton)
        view.addSubview(nameErrorLabel)
        view.addSubview(emailErrorLabel)
        view.addSubview(passwordErrorLabel)
        view.addSubview(confirm_passwordErrorLabel)

        let verticalSpacing = 50
        let edgeMargin = 20
        let fieldHeight = 40

        nameTextField.snp_makeConstraints {
            (field) -> Void in
            field.topMargin.equalTo(self.view.snp_top).offset(100)
            field.leftMargin.equalTo(edgeMargin)
            field.rightMargin.equalTo(-edgeMargin)
            field.height.equalTo(fieldHeight)
        }

        emailTextField.snp_makeConstraints {
            (field) -> Void in
            field.topMargin.equalTo(nameTextField.snp_bottom).offset(verticalSpacing)
            field.leftMargin.equalTo(edgeMargin)
            field.rightMargin.equalTo(-edgeMargin)
            field.height.equalTo(fieldHeight)
        }

        passwordTextField.snp_makeConstraints {
            (field) -> Void in
            field.topMargin.equalTo(emailTextField.snp_bottom).offset(verticalSpacing)
            field.leftMargin.equalTo(edgeMargin)
            field.rightMargin.equalTo(-edgeMargin)
            field.height.equalTo(fieldHeight)
        }

        confirm_passwordTextField.snp_makeConstraints {
            (field) -> Void in
            field.topMargin.equalTo(passwordTextField.snp_bottom).offset(verticalSpacing)
            field.leftMargin.equalTo(edgeMargin)
            field.rightMargin.equalTo(-edgeMargin)
            field.height.equalTo(fieldHeight)
        }

        submitButton.snp_makeConstraints {
            (button) -> Void in
            button.topMargin.equalTo(confirm_passwordTextField.snp_bottom).offset(verticalSpacing)
            button.centerX.equalTo(self.view.snp_centerX)
            button.width.equalTo(100)
            button.height.equalTo(40)
        }

        nameErrorLabel.snp_makeConstraints {
            (label) -> Void in
            label.bottom.equalTo(nameTextField.snp_top).offset(-3)
            label.right.equalTo(nameTextField.snp_right)
        }

        emailErrorLabel.snp_makeConstraints {
            (label) -> Void in
            label.bottom.equalTo(emailTextField.snp_top).offset(-3)
            label.right.equalTo(emailTextField.snp_right)
        }

        passwordErrorLabel.snp_makeConstraints {
            (label) -> Void in
            label.bottom.equalTo(passwordTextField.snp_top).offset(-3)
            label.right.equalTo(passwordTextField.snp_right)
        }

        confirm_passwordErrorLabel.snp_makeConstraints {
            (label) -> Void in
            label.bottom.equalTo(confirm_passwordTextField.snp_top).offset(-3)
            label.right.equalTo(confirm_passwordTextField.snp_right)
        }

        validator.registerField(nameTextField, errorLabel: nameErrorLabel, rules: [RequiredRule()])
        validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule()])
        validator.registerField(passwordTextField, errorLabel: passwordErrorLabel, rules: [RequiredRule(), PasswordRule()])
        validator.registerField(confirm_passwordTextField, errorLabel: confirm_passwordErrorLabel, rules: [RequiredRule(), ConfirmationRule(confirmField: passwordTextField)])
    }

    func submitPressed(sender:UIButton){
        clearValidationErrors()
        validator.validate(self)
    }

    func validationSuccessful() {
        API.signUp(nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, confirm_password: confirm_passwordTextField.text!)
        .onSuccess{ id in
            self.navigationController!.popViewControllerAnimated(true)
        }
        .onFailure{error in
            print("Error in signup")
        }
    }


    func validationFailed(errors: [UITextField:ValidationError]) {
        // turn the fields to red
        for (field, error) in validator.errors {
            field.layer.borderColor = UIColor.redColor().CGColor
            field.layer.borderWidth = 1.0
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.hidden = false
        }
    }

    func clearValidationErrors() {
        nameTextField.layer.borderWidth = 0.0
        nameErrorLabel.hidden = true

        emailTextField.layer.borderWidth = 0.0
        emailErrorLabel.hidden = true

        passwordTextField.layer.borderWidth = 0.0
        passwordErrorLabel.hidden = true

        confirm_passwordTextField.layer.borderWidth = 0.0
        confirm_passwordErrorLabel.hidden = true
    }


}

