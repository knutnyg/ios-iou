

import Foundation
import SnapKit

class EditProfileViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user:User!
    var mainViewViewController:MainViewController!
    
    var nameTextField:UITextField!
    var shortNameTextField:UITextField!
    var emailTextField:UITextField!
    
    var nameLabel:UILabel!
    var shortNameLabel:UILabel!
    var emailLabel:UILabel!

    var photoImageView:UIImageView!
    
    var updateButton:UIButton!
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "Edit Profile"
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        nameTextField = createTextField(user.name)
        shortNameTextField = createTextField(user.shortName)
        emailTextField = createTextField(user.email)
        
        nameLabel = createLabel("Full name:", font: UIFont(name: "HelveticaNeue",size: 18)!)
        shortNameLabel = createLabel("Short name:", font: UIFont(name: "HelveticaNeue",size: 18)!)
        emailLabel = createLabel("Email:", font: UIFont(name: "HelveticaNeue",size: 18)!)

        photoImageView = ImageUtils.createScaledRoundImageView(UIImage(named: "profile.png")!, height: 100, width: 100)
        
        let tapGestureRecognizer  = UITapGestureRecognizer(target: self, action: "imageViewTapped:")
        photoImageView.userInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGestureRecognizer)
        
        updateButton = createButton("Update profile", font: UIFont(name: "HelveticaNeue",size: 18)!)
        updateButton.addTarget(self, action: "updatePressed:", forControlEvents: .TouchUpInside)
        
        view.addSubview(photoImageView)
        
        view.addSubview(nameTextField)
        view.addSubview(shortNameTextField)
        view.addSubview(emailTextField)
        
        view.addSubview(nameLabel)
        view.addSubview(shortNameLabel)
        view.addSubview(emailLabel)
        
        view.addSubview(updateButton)
        
        let edgeMargin = 20
        let fieldHeight = 40
        
        photoImageView.snp_makeConstraints {
                (make) -> Void in
                make.topMargin.equalTo(self.view.snp_top).offset(100)
                make.centerX.equalTo(self.view.snp_centerX)
        }
        
        let elements:[UIView] = [photoImageView, nameTextField, shortNameTextField, emailTextField]
        let labels:[UIView?] = [nil, nameLabel, shortNameLabel, emailLabel]
        
        for i in 1...elements.count - 1 {
            elements[i].snp_makeConstraints {
                (make) -> Void in
                make.topMargin.equalTo(elements[i-1].snp_bottom).offset(50)
                make.leftMargin.equalTo(edgeMargin)
                make.rightMargin.equalTo(-edgeMargin)
                make.height.equalTo(fieldHeight)
            }
            
            if let label = labels[i] {
                label.snp_makeConstraints {
                    (label) -> Void in
                    label.bottom.equalTo(elements[i].snp_top).offset(-5)
                    label.leftMargin.equalTo(edgeMargin)
                }
            }
        }
        
        updateButton.snp_makeConstraints {
            (make) -> Void in
            make.topMargin.equalTo(self.emailTextField.snp_bottom).offset(50)
            make.centerX.equalTo(self.view.snp_centerX)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        API.getImageForUser(user)
            .onSuccess{image in
                self.photoImageView.image = ImageUtils.scaleImage(image, height: 100, width: 100)
            }
            .onFailure{error in
                print("failure getting image")
            }
    }
    
    func updatePressed(sender: UIButton){
        
        user.name = nameTextField.text
        user.shortName = shortNameTextField.text
        user.email = emailTextField.text
        
        API.updateUser(user)
            .onSuccess{ user in
                self.navigationController?.popToViewController(self.mainViewViewController, animated: true)}
            .onFailure{ error in
                print("error")
        }
    }
    
    func imageViewTapped(sender: UIImageView){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let scaledImage = ImageUtils.scaleImage(image, height: 200, width: 200)
        
        API.uploadImageForUser(scaledImage).onSuccess{response in
            self.photoImageView.image = ImageUtils.scaleImage(image, height: 100, width: 100)
            }
            .onFailure{error in
                print("failure!")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}