
import Foundation
import UIKit

class ProfileViewController : UIViewController {

    var profileImage:UIImage!
    var profileImageView:UIImageView!
    var nameLabel:UILabel!

    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()

        profileImage = UIImage(named: "profile.png")
        profileImageView = UIImageView(image: profileImage)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.cornerRadius = 100/2
        print(profileImage.size.width)
        profileImageView.clipsToBounds = true

        nameLabel = createLabel("Welcome Knut Nygaard")

        view.addSubview(profileImageView)
        view.addSubview(nameLabel)

        let views:[String:AnyObject] = ["profile":profileImageView, "name":nameLabel]

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[profile(100)]-[name]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }

    func refreshProfile(){
        API.getImageForUser(API.currentUser!).onSuccess{image in
            self.profileImageView.image = image

        }
    }
}