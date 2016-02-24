
import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftValidator

class DefaultLoginViewController: UIViewController, ValidationDelegate{
    
    var forgotPasswordButton:UIButton!
    var signInButton:UIButton!

    var usernameTextField:UITextField!
    var passwordTextField:UITextField!

    var usernameTextFieldErrorLabel:UILabel!
    var passwordTextFieldErrorLabel:UILabel!

    var validator:Validator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = UIColor.whiteColor()
        
        setupNavigationBar()
        forgotPasswordButton = createButton("Forgot password", font: UIFont(name: "HelveticaNeue",size: 22)!)
        signInButton = createButton("Sign in!", font: UIFont(name: "HelveticaNeue",size: 22)!)
        
        usernameTextField = createTextField("username")
        passwordTextField = createTextField("password")
        passwordTextField.secureTextEntry = true

        usernameTextFieldErrorLabel = createLabel("")
        usernameTextFieldErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextFieldErrorLabel.hidden = true
        view.addSubview(usernameTextFieldErrorLabel)

        passwordTextFieldErrorLabel = createLabel("")
        passwordTextFieldErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextFieldErrorLabel.hidden = true
        view.addSubview(passwordTextFieldErrorLabel)

        forgotPasswordButton.addTarget(self, action: "forgotPasswordButtonPressed:", forControlEvents: .TouchUpInside)
        signInButton.addTarget(self, action: "signInButtonPressed:", forControlEvents: .TouchUpInside)

        validator = Validator()
        validator.registerField(usernameTextField, errorLabel: usernameTextFieldErrorLabel, rules: [RequiredRule(), EmailRule(message: "Invalid email")])
        validator.registerField(passwordTextField, errorLabel: passwordTextFieldErrorLabel, rules: [RequiredRule()])

        let views = ["forgotPasswordButton":forgotPasswordButton, "signInButton":signInButton, "usernameTextField":usernameTextField,"passwordTextField":passwordTextField, "usernameErrorLabel":usernameTextFieldErrorLabel, "passwordErrorLabel":passwordTextFieldErrorLabel]

        view.addSubview(forgotPasswordButton)
        view.addSubview(signInButton)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)

        view.addSubview(usernameTextFieldErrorLabel)
        view.addSubview(passwordTextFieldErrorLabel)

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[usernameTextField(60)]-40-[passwordTextField(60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[passwordTextField(60)]-40-[signInButton(60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[passwordTextField(60)]-40-[forgotPasswordButton(60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[usernameTextField]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[passwordTextField]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[signInButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[forgotPasswordButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[usernameErrorLabel]-[usernameTextField]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[usernameErrorLabel]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[passwordErrorLabel]-[passwordTextField]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[passwordErrorLabel]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    func signInButtonPressed(sender:UIButton){
        clearValidationErrors()
        validator.validate(self)
    }
    
    func forgotPasswordButtonPressed(sender:UIButton){
        let vc = ForgotPasswordViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupNavigationBar(){
//        let font = UIFont(name: "Verdana", size:22)!
//        let attributes:[String : AnyObject] = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationItem.title = "Log In"
//        navigationController!.navigationBar.titleTextAttributes = attributes
        
        let verticalOffset = 1.5 as CGFloat;
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(verticalOffset, forBarMetrics: UIBarMetrics.Default)
    }

    func validationSuccessful() {

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

            self.navigationController?.pushViewController(vc, animated: true)
        }
        .onFailure{ error in
            let alertController = UIAlertController(title: "", message:
            "Unable to log in\nPlease verify your credentials", preferredStyle: UIAlertControllerStyle.Alert)
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
        usernameTextField.layer.borderWidth = 0.0
        usernameTextFieldErrorLabel.hidden = true
        passwordTextField.layer.borderWidth = 0.0
        passwordTextFieldErrorLabel.hidden = true
    }
}
