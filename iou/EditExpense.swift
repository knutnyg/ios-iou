
import Foundation
import UIKit

class EditExpense : UIViewController {
    
    var delegate:UIViewController!
    
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
    
    var membersSelectorTableViewController:MembersTableViewController!
    var group:Group!
    var selectedDate:NSDate!
    
    var selectedMembers:[User] = []
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        let currentUser = API.currentUser!
     
        paidByLabel = createLabel("Paid by:")
        paidByTextField = createTextField("")
        paidByTextField.text = currentUser.name
        
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
        
        membersSelectorTableViewController = MembersTableViewController()
        membersSelectorTableViewController.delegate = self
        membersSelectorTableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
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

        addChildViewController(membersSelectorTableViewController)
        view.addSubview(membersSelectorTableViewController.view)
        
        //Constraints:
        
        let views = ["paidLabel":paidByLabel, "paidTextField":paidByTextField, "commentLabel":commentLabel, "commentTextField":commentTextField, "dateLabel":dateLabel, "dateTextField":dateTextField, "amountLabel":amountLabel, "amountTextField":amountTextField, "saveButton":saveButton, "cancelButton":cancelButton, "table":membersSelectorTableViewController.view]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[paidLabel]-[paidTextField]-[commentLabel]-[commentTextField]-[dateLabel]-[dateTextField]-[amountLabel]-[amountTextField]-[saveButton]-[table]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
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
        API.newExpense(Expense(participants: selectedMembers, amount: amount!, date: datePicker.date, groupId: group.id, comment: commentTextField.text!, creator: API.currentUser!))
            .onSuccess{ expense in
                self.navigationController?.popViewControllerAnimated(true)
            }
            .onFailure{err in print("failure")}

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
    
    init(group:Group){
        super.init(nibName: nil, bundle: nil)
        self.group = group
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
