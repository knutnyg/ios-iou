import Foundation
import UIKit
import SnapKit
import SwiftValidator

class NewExpense: UIViewController, UITextFieldDelegate, ValidationDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var delegate: GroupViewController!

    var paidByLabel: UILabel!
    var paidByTextField: UITextField!
    var commentLabel: UILabel!
    var commentTextField: UITextField!
    var dateLabel: UILabel!
    var dateTextField: UITextField!
    var datePicker: UIDatePicker!
    var amountLabel: UILabel!
    var amountTextField: UITextField!
    var commentErrorLabel: UILabel!
    var amountErrorLabel: UILabel!

    var addParticipantsButton: UIButton!
    var groupMembers: [User]!

    var memberPickerView: UIPickerView!

    var selectedDate: NSDate!

    var validator: Validator!

    override func viewDidLoad() {

        view.backgroundColor = UIColor.whiteColor()
        setupNavigationBar()
        validator = Validator()

        memberPickerView = UIPickerView()
        memberPickerView.delegate = self
        memberPickerView.dataSource = self

        setPaidBy()

        paidByLabel = createLabel("Paid by:", font: UIFont(name: "HelveticaNeue", size: 18)!)
        commentLabel = createLabel("Comment:", font: UIFont(name: "HelveticaNeue", size: 18)!)
        dateLabel = createLabel("Date:", font: UIFont(name: "HelveticaNeue", size: 18)!)
        amountLabel = createLabel("Amount:", font: UIFont(name: "HelveticaNeue", size: 18)!)

        paidByTextField = createTextField("")
        paidByTextField.text = API.currentUser!.name
        paidByTextField.inputView = memberPickerView

        dateTextField = createTextField("")
        dateTextField.text = NSDate().shortPrintable()
        dateTextField.inputView = datePicker

        datePicker = UIDatePicker()
        datePicker.addTarget(self, action: "dateSelected:", forControlEvents: .ValueChanged)
        datePicker.datePickerMode = UIDatePickerMode.Date

        commentTextField = createTextField("Enter a describing comment")
        commentTextField.delegate = self

        amountTextField = createTextField("$$")
        amountTextField.keyboardType = .DecimalPad
        amountTextField.delegate = self

        commentErrorLabel = createLabel("")
        amountErrorLabel = createLabel("")

        commentErrorLabel.hidden = true
        amountErrorLabel.hidden = true

        addParticipantsButton = createButton("Add participants >", font: UIFont(name: "HelveticaNeue", size: 20)!)
        addParticipantsButton.addTarget(self, action: "addParticipantsPressed:", forControlEvents: .TouchUpInside)

        validator.registerField(commentTextField, errorLabel: commentErrorLabel, rules: [RequiredRule()])
        validator.registerField(amountTextField, errorLabel: amountErrorLabel, rules: [RequiredRule(), IsNumericRule()])

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

        let edgeMargin = 20
        let verticalSpacing = 45

        let comp: [ComponentWrapper] = [
                ComponentWrapper(view: paidByLabel, rules: ConstraintRules().snapBottom(paidByTextField.snp_top).marginBottom(5).snapLeft(view.snp_left).marginLeft(edgeMargin)),
                ComponentWrapper(view: commentLabel, rules: ConstraintRules().snapBottom(commentTextField.snp_top).marginBottom(5).snapLeft(view.snp_left).marginLeft(edgeMargin)),
                ComponentWrapper(view: dateLabel, rules: ConstraintRules().snapBottom(dateTextField.snp_top).marginBottom(5).snapLeft(view.snp_left).marginLeft(edgeMargin)),
                ComponentWrapper(view: amountLabel, rules: ConstraintRules().snapBottom(amountTextField.snp_top).marginBottom(5).snapLeft(view.snp_left).marginLeft(edgeMargin)),
                ComponentWrapper(view: paidByTextField, rules: ConstraintRules().snapTop(view.snp_top).marginTop(130).horizontalFullWithMargin(view, margin: edgeMargin).height(50)),
                ComponentWrapper(view: commentTextField, rules: ConstraintRules().snapTop(paidByTextField.snp_bottom).marginTop(verticalSpacing).horizontalFullWithMargin(view, margin: edgeMargin).height(50)),
                ComponentWrapper(view: dateTextField, rules: ConstraintRules().snapTop(commentTextField.snp_bottom).marginTop(verticalSpacing).horizontalFullWithMargin(view, margin: edgeMargin).height(50)),
                ComponentWrapper(view: amountTextField, rules: ConstraintRules().snapTop(dateTextField.snp_bottom).marginTop(verticalSpacing).horizontalFullWithMargin(view, margin: edgeMargin).height(50)),
                ComponentWrapper(view: commentErrorLabel, rules: ConstraintRules().snapBottom(commentTextField.snp_top).marginBottom(5).snapRight(view.snp_right).marginRight(edgeMargin)),
                ComponentWrapper(view: amountErrorLabel, rules: ConstraintRules().snapBottom(amountTextField.snp_top).marginBottom(5).snapRight(view.snp_right).marginRight(edgeMargin)),
                ComponentWrapper(view: addParticipantsButton, rules: ConstraintRules().snapTop(amountTextField.snp_bottom).marginTop(verticalSpacing).snapRight(view.snp_right).marginRight(edgeMargin)),
        ]

        SnapKitHelpers.setConstraints(view, components: comp)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        clearValidationErrors()
    }


    func setPaidBy() {
        if let index = groupMembers.indexOf({ $0.id == API.currentUser!.id }) {
            memberPickerView.selectRow(index, inComponent: 0, animated: false)
        }
    }

    func dateSelected(sender: UIDatePicker) {
        dateTextField.text = sender.date.shortPrintable()
    }

    func addParticipantsPressed(sender: UIButton) {
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

    func setupNavigationBar() {
        navigationItem.title = "Add Expense"
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }

    func moveKeyboardUp() {
        UIView.animateWithDuration(0.25, animations: {
            self.view.frame.origin.y += 150
        })
    }

    func moveKeyboardDown() {
        UIView.animateWithDuration(0.25, animations: {
            self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height + 150)
            self.view.frame.origin.y -= 150
        })
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == commentTextField || textField == amountTextField {
            moveKeyboardDown()
        }
    }

    func textFieldDidEndEditing(textField: UITextField) {
        if textField == commentTextField || textField == amountTextField {
            moveKeyboardUp()
        }
    }

    func validationSuccessful() {
        let amount = normalizeNumberInText(amountTextField.text!).doubleValue
        let date = datePicker.date
        resetView()
        let vc = AddParticipantsParent()
        vc.delegate = delegate
        vc.expense = Expense(participants: [], amount: amount, date: date, groupId: delegate.group.id, created: NSDate(), updated: NSDate(), comment: commentTextField.text!, creator: groupMembers[memberPickerView.selectedRowInComponent(0)])
        vc.type = Type.NEW
        navigationController?.pushViewController(vc, animated: true)
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

    func resetView() {
        commentTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
    }


    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paidByTextField.text = groupMembers[row].name
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groupMembers[row].name
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupMembers.count
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

}
