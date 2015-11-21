
import Foundation
import UIKit
import SnapKit
import SwiftValidator

class NewExpense : UIViewController, UITextFieldDelegate, ValidationDelegate{
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
    var commentErrorLabel:UILabel!
    var amountErrorLabel:UILabel!

    var addParticipantsButton:UIButton!

    var selectedDate:NSDate!

    var validator: Validator!

//    var originY: CGFloat!
//    var orginalHeight: CGFloat!

    override func viewDidLoad() {

        view.backgroundColor = UIColor.whiteColor()
        setupNavigationBar()
        validator = Validator()

//        originY = view.frame.origin.y
//        orginalHeight = view.frame.height

        paidByLabel = createLabel("Paid by:", font: UIFont(name: "HelveticaNeue",size: 18)!)
        paidByTextField = createTextField("")
        paidByTextField.text = API.currentUser!.name

        commentLabel = createLabel("Comment:", font: UIFont(name: "HelveticaNeue",size: 18)!)
        commentTextField = createTextField("Enter a describing comment")
        commentTextField.delegate = self

        dateLabel = createLabel("Date:", font: UIFont(name: "HelveticaNeue",size: 18)!)
        datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date

        dateTextField = createTextField("")
        dateTextField.text = NSDate().shortPrintable()
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: "dateSelected:", forControlEvents: .ValueChanged)

        amountLabel = createLabel("Amount:", font: UIFont(name: "HelveticaNeue",size: 18)!)
        amountTextField = createTextField("$$")
        amountTextField.keyboardType = .DecimalPad
        amountTextField.delegate = self

        commentErrorLabel = createLabel("")
        amountErrorLabel = createLabel("")

        commentErrorLabel.hidden = true
        amountErrorLabel.hidden = true

        addParticipantsButton = createButton("Add participants >", font: UIFont(name: "HelveticaNeue",size: 20)!)
        addParticipantsButton.addTarget(self, action: "addParticipantsPressed:", forControlEvents: .TouchUpInside)

        validator.registerField(commentTextField, errorLabel: commentErrorLabel, rules: [RequiredRule()])
        validator.registerField(amountTextField, errorLabel: amountErrorLabel, rules: [RequiredRule(), FloatRule()])

        view.addSubview(paidByLabel)
        view.addSubview(paidByTextField)
        view.addSubview(commentLabel)
        view.addSubview(commentTextField)
        view.addSubview(dateLabel)
        view.addSubview(dateTextField)
        view.addSubview(amountLabel)
        view.addSubview(amountTextField)
        view.addSubview(addParticipantsButton)
        view.addSubview(commentErrorLabel)
        view.addSubview(amountErrorLabel)

        //Constraints:

        let verticalSpacing = 45
        let edgeMargin = 20
        let fieldHeight = 50

        let elements:[UIView] = [paidByTextField, dateTextField, commentTextField, amountTextField]
        let labels:[UIView] = [paidByLabel, dateLabel, commentLabel, amountLabel]
        let errorLabels:[UIView?] = [nil, nil, commentErrorLabel, amountErrorLabel]

        for i in 0...elements.count - 1 {

            //First element
            if i == 0 {
                elements[i].snp_makeConstraints {
                    (field) -> Void in
                    field.topMargin.equalTo(self.view.snp_top).offset(130)
                    field.leftMargin.equalTo(edgeMargin)
                    field.rightMargin.equalTo(-edgeMargin)
                    field.height.equalTo(fieldHeight)
                }

                labels[i].snp_makeConstraints {
                    (label) -> Void in
                    label.bottom.equalTo(elements[i].snp_top).offset(-5)
                    label.leftMargin.equalTo(edgeMargin)
                }
            } else {
                //Following elements
                elements[i].snp_makeConstraints {
                    (field) -> Void in
                    field.top.equalTo(elements[i-1].snp_bottom).offset(verticalSpacing)
                    field.leftMargin.equalTo(edgeMargin)
                    field.rightMargin.equalTo(-edgeMargin)
                    field.height.equalTo(fieldHeight)
                }

                labels[i].snp_makeConstraints {
                    (label) -> Void in
                    label.bottom.equalTo(elements[i].snp_top).offset(-5)
                    label.leftMargin.equalTo(edgeMargin)
                }

                if let errorLabel = errorLabels[i] {
                    errorLabel.snp_makeConstraints {
                        (label) -> Void in
                        label.bottom.equalTo(elements[i].snp_top).offset(-3)
                        label.right.equalTo(elements[i].snp_right)
                    }
                }
            }
        }

        addParticipantsButton.snp_makeConstraints {
            (button) -> Void in
            button.topMargin.equalTo(amountTextField.snp_bottom).offset(verticalSpacing)
            button.right.equalTo(self.view.snp_right).offset(-verticalSpacing)
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        clearValidationErrors()
    }


    func dateSelected(sender:UIDatePicker){
        dateTextField.text = sender.date.shortPrintable()
    }

    func addParticipantsPressed(sender:UIButton){
        clearValidationErrors()
        validator.validate(self)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    func setupNavigationBar(){
        navigationItem.title = "Add Expense"
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }

    func moveKeyboardUp() {
        UIView.animateWithDuration(0.25, animations: {
//            self.view.frame = CGRectMake(0 , 0, self.view.frame.width, self.view.frame.height - 150)
            self.view.frame.origin.y += 150
        })
    }

    func moveKeyboardDown(){
        UIView.animateWithDuration(0.25, animations: {
            self.view.frame = CGRectMake(0 , 0, self.view.frame.width, self.view.frame.height + 150)
            self.view.frame.origin.y -= 150
        })
    }

    func textFieldDidBeginEditing(_ textField: UITextField!) {
        if textField == commentTextField || textField == amountTextField {

            moveKeyboardDown()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField!) {
        if textField == commentTextField || textField == amountTextField {
            moveKeyboardUp()
        }
    }

    func validationSuccessful() {
        let amount = normalizeNumberInText(amountTextField.text!).doubleValue
        resetView()
        let vc = AddParticipantsParent()
        vc.delegate = delegate
        vc.expense = Expense(participants: [], amount: amount, date: datePicker.date, groupId: API.currentGroup!.id, comment: commentTextField.text!, creator: API.currentUser!)
        navigationController?.pushViewController(vc,animated: true)
    }

    func validationFailed(errors: [UITextField:ValidationError]) {
        // turn the fields to red
        for (field, error) in validator.errors {
            field.layer.borderColor = UIColor.redColor().CGColor
            field.layer.borderWidth = 1.0
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.hidden = false
        }
    }

    func clearValidationErrors() {
        commentTextField.layer.borderWidth = 0.0
        commentErrorLabel.hidden = true

        amountTextField.layer.borderWidth = 0.0
        amountErrorLabel.hidden = true
    }

    func resetView(){
        commentTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()

//        self.view.frame = CGRectMake(0 , 0, self.view.frame.width, orginalHeight)
//        self.view.frame.origin.y = originY
    }

}
