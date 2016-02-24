
import Foundation
import UIKit

func createfontAwesomeButton(unicode:String) -> UIButton{
    let font = UIFont(name: "FontAwesome", size: 22)!
    let size: CGSize = unicode.sizeWithAttributes([NSFontAttributeName: font])
    
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    button.setTitle(unicode, forState: .Normal)
    button.titleLabel!.font = font
    button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    button.setTitleColor(UIColor(netHex: 0x19B5FE), forState: .Highlighted)
    
    return button
}