
import Foundation
import UIKit

class ExpenseCell : UITableViewCell {
    
    var payee:UILabel!
    var date:UILabel!
    var comment:UILabel!
    var amount:UILabel!
    var split:UILabel!
    
    var expense:Expense!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        payee = createLabel("",font:UIFont(name: "HelveticaNeue", size:17)!)
        date = createLabel("",font:UIFont(name: "HelveticaNeue", size:17)!)
        date.textAlignment = .Right
        comment = createLabel("",font:UIFont(name: "HelveticaNeue", size:13)!)
        comment.numberOfLines = 2
        amount = createLabel("",font:UIFont(name: "HelveticaNeue", size:13)!)
        amount.textAlignment = .Right
        split = createLabel("",font:UIFont(name: "HelveticaNeue", size:13)!)
        split.textAlignment = .Right
        
        contentView.addSubview(payee)
        contentView.addSubview(date)
        contentView.addSubview(comment)
        contentView.addSubview(amount)
        contentView.addSubview(split)
        
        let views:[String : AnyObject] = ["payee":payee, "date":date, "comment":comment, "amount":amount, "split":split]
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[payee(200)]",
                options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[comment(200)]",
                options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[date(150)]-|",
        options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[amount(100)]-|",
        options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[split(100)]-|",
        options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[payee(17)]-2-[comment]",
                options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[date(17)]-2-[amount]-2-[split]",
                options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    func updateLabels(){
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        if(self.expense.creator.shortName == nil) {
            payee.text = self.expense.creator.name
        } else {
            payee.text = self.expense.creator.shortName
        }

        if expense.date != nil {
            date.text = self.expense.date.mediumPrintable()
        } else {
            date.text = "nil"
        }

        comment.text = self.expense.comment

        amount.text = localeStringFromNumber(NSLocale(localeIdentifier: "nb_NO"), number: expense.amount)
        split.text = localeStringFromNumber(NSLocale(localeIdentifier: "nb_NO"), number: expense.amount / Double(expense.participants.count))

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
