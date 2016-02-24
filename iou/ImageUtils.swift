
import Foundation
import UIKit

class ImageUtils {
    
    static func scaleImage(image:UIImage, height: CGFloat, width: CGFloat) -> UIImage{
        
        let rect = CGRectMake(0, 0, width, height)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width,height: height), false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    static func createScaledRoundImageView(inputImage:UIImage, height:CGFloat, width:CGFloat) -> UIImageView {
        let image = scaleImage(inputImage, height: height, width: width)
        let iv = UIImageView(image: image)

        iv.layer.borderWidth = 1.0
        iv.layer.masksToBounds = false
        iv.layer.borderColor = UIColor.whiteColor().CGColor
        iv.layer.cornerRadius = image.size.width/2
        iv.clipsToBounds = true

        return iv

    }

    static func createRoundImageView(image:UIImage) -> UIImageView {
        let iv = UIImageView(image: image)
        
        iv.layer.borderWidth = 1.0
        iv.layer.masksToBounds = false
        iv.layer.borderColor = UIColor.whiteColor().CGColor
        iv.layer.cornerRadius = image.size.width/2
        iv.clipsToBounds = true
        
        return iv

    }
}

