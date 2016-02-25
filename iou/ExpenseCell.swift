import Foundation
import UIKit

class ExpenseCell: UITableViewCell {

    var payee: UILabel!
    var date: UILabel!
    var comment: UILabel!
    var amount: UILabel!
    var split: UILabel!

    var expense: Expense!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        payee = createLabel("", font: UIFont(name: "HelveticaNeue", size: 17)!)
        date = createLabel("", font: UIFont(name: "HelveticaNeue", size: 17)!)
        comment = createLabel("", font: UIFont(name: "HelveticaNeue", size: 13)!)
        amount = createLabel("", font: UIFont(name: "HelveticaNeue", size: 13)!)
        split = createLabel("", font: UIFont(name: "HelveticaNeue", size: 13)!)

        comment.numberOfLines = 2

        date.textAlignment = .Right
        amount.textAlignment = .Right
        split.textAlignment = .Right

        contentView.addSubview(payee)
        contentView.addSubview(date)
        contentView.addSubview(comment)
        contentView.addSubview(amount)
        contentView.addSubview(split)

        let rules = [
                ConstraintRules()
                    .snapLeft(contentView.snp_left)
                    .marginLeft(8)
                    .width(200)
                    .snapTop(contentView.snp_top)
                    .marginTop(4),
                ConstraintRules()
                    .snapLeft(contentView.snp_left)
                    .marginLeft(8)
                    .width(200)
                    .snapTop(payee.snp_bottom)
                    .marginTop(2),
                ConstraintRules()
                    .snapRight(contentView.snp_right)
                    .marginRight(8)
                    .width(150)
                    .snapTop(contentView.snp_top)
                    .marginTop(2),
                ConstraintRules()
                    .snapRight(contentView.snp_right)
                    .marginRight(8)
                    .width(100)
                    .snapTop(date.snp_bottom)
                    .marginTop(2),
                ConstraintRules()
                    .snapRight(contentView.snp_right)
                    .marginRight(8)
                    .width(100)
                    .snapTop(amount.snp_bottom)
                    .marginTop(2)
        ]

        let components:[UIView] = [payee, comment, date, amount, split]

        SnapKitHelpers.setConstraints(contentView, components:  components, rules: rules)
    }

    func updateLabels() {

        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        if (self.expense.creator.shortName == nil) {
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
