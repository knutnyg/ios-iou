
import Foundation

class NewExpense : UIViewController {
    var delegate:GroupViewController!

    var paidByLabel:UILabel!
    var paidByTextField:UITextField!
    var commentLabel:UILabel!
    var commentTextField:UITextField!
    var dateLabel:UILabel!
    var dateTextField:UITextField!
    var datePicker:UIDatePicker!
    var amountLabel:UILabel!
    var amountTextField:UITextField!

    var saveButton:UIButton!
    var cancelButton:UIButton!

    var addParticipantsToExpenseTableViewController: AddParticipantsToExpenseTableViewController!
    var selectedDate:NSDate!

    override func viewDidLoad() {

        view.backgroundColor = UIColor.whiteColor()

        paidByLabel = createLabel("Paid by:")
        paidByTextField = createTextField("")
        paidByTextField.text = API.currentUser!.name

        commentLabel = createLabel("Comment:")
        commentTextField = createTextField("Enter a describing comment")

        dateLabel = createLabel("Date:")
        datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date

        dateTextField = createTextField("")
        dateTextField.text = NSDate().shortPrintable()
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: "dateSelected:", forControlEvents: .ValueChanged)

        amountLabel = createLabel("Amount:")
        amountTextField = createTextField("$$")
        amountTextField.keyboardType = UIKeyboardType.NumberPad

        saveButton = createButton("Send")
        saveButton.addTarget(self, action: "savePressed:", forControlEvents: .TouchUpInside)

        cancelButton = createButton("Cancel")
        cancelButton.addTarget(self, action: "cancelPressed:", forControlEvents: .TouchUpInside)

        addParticipantsToExpenseTableViewController = AddParticipantsToExpenseTableViewController()
        addParticipantsToExpenseTableViewController.delegate = self
        addParticipantsToExpenseTableViewController.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(paidByLabel)
        view.addSubview(paidByTextField)
        view.addSubview(commentLabel)
        view.addSubview(commentTextField)
        view.addSubview(dateLabel)
        view.addSubview(dateTextField)
        view.addSubview(amountLabel)
        view.addSubview(amountTextField)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)

        addChildViewController(addParticipantsToExpenseTableViewController)
        view.addSubview(addParticipantsToExpenseTableViewController.view)

        //Constraints:

        let views = ["paidLabel":paidByLabel, "paidTextField":paidByTextField, "commentLabel":commentLabel, "commentTextField":commentTextField, "dateLabel":dateLabel, "dateTextField":dateTextField, "amountLabel":amountLabel, "amountTextField":amountTextField, "saveButton":saveButton, "cancelButton":cancelButton, "table": addParticipantsToExpenseTableViewController.view]

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-67-[paidLabel]-[paidTextField]-[commentLabel]-[commentTextField]-[dateLabel]-[dateTextField]-[amountLabel]-[amountTextField]-[saveButton]-[table]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[paidTextField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[commentTextField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[dateTextField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[amountTextField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[saveButton]-20-[cancelButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: saveButton, attribute: .CenterY, relatedBy: .Equal, toItem: cancelButton, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: saveButton, attribute: .Width, relatedBy: .Equal, toItem: cancelButton, attribute: .Width, multiplier: 1, constant: 0))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[table]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }

    func dateSelected(sender:UIDatePicker){
        dateTextField.text = sender.date.shortPrintable()
    }

    func savePressed(sender:UIButton){
        let amount = Double(amountTextField.text!)
        API.newExpense(Expense(participants: addParticipantsToExpenseTableViewController.selectedMembers, amount: amount!, date: datePicker.date, groupId: API.currentGroup!.id, comment: commentTextField.text!, creator: API.currentUser!))
        .onSuccess{ expense in
            self.navigationController?.popViewControllerAnimated(true)
        }
        .onFailure{err in print(err)}

    }

    func cancelPressed(sender:UIButton){
        navigationController?.popViewControllerAnimated(true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
