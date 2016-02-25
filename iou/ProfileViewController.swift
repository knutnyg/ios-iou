
import Foundation
import UIKit
import SnapKit

class ProfileViewController : UIViewController {

    var profileImage:UIImage!
    var profileImageView:UIImageView!
    var nameLabel:UILabel!

    override func viewDidLoad() {

        view.backgroundColor = UIColor.whiteColor()

        profileImageView = createProfileImageView()
        nameLabel = createLabel("")

        view.addSubview(profileImageView)
        view.addSubview(nameLabel)

        let components = [profileImageView, nameLabel]

        let rules = [
                ConstraintRules()
                    .snapTop(view.snp_top)
                    .marginTop(30)
                    .height(100)
                    .centerX()
                    .width(100),
                ConstraintRules()
                    .snapTop(profileImageView.snp_bottom)
                    .centerX()
        ]

        SnapKitHelpers.setConstraints(view, components: components, rules: rules)
    }
    
    override func viewDidAppear(animated: Bool) {
        if API.currentUser != nil {
            refreshProfile()
        }

    }

    func refreshProfile(){
        nameLabel.text = "Welcome \(API.currentUser!.name)"
        API.getImageForUser(API.currentUser!).onSuccess{image in
            self.profileImageView.image = image
        }

    }

    func createProfileImageView() -> UIImageView {
        let profileImage = UIImage(named: "profile.png")
        let profileImageView = UIImageView(image: profileImage)

        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.cornerRadius = 100/2
        profileImageView.clipsToBounds = true

        return profileImageView
    }
}