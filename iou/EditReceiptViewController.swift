//
//  ReceiptViewController.swift
//  iou
//
//  Created by Knut Nygaard on 4/30/15.
//  Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class EditReceiptViewController : UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate{

    var group:Group!
    var receipt:Expense!
    var delegate:ExpensesTableViewController!

    var payedByLabel:UILabel!
    var commentLabel:UILabel!
    var dateLabel:UILabel!
    var amountLabel:UILabel!
    
    var payedByTF:UITextField!
    var commentTF:UITextView!
    var dateTF:UITextField!
    var amountTF:UITextField!
    
    var saveButton:UIButton!
    
    var datePicker:UIDatePicker!
    var namePicker:UIPickerView!
    
    override func viewDidLoad() {
        
        
        
        view.backgroundColor = UIColor.whiteColor()
    
        datePicker = createDatePicker()
        datePicker.backgroundColor = UIColor.whiteColor()
        
        namePicker = UIPickerView()
        namePicker.dataSource = self
        namePicker.delegate = self
        var payeeIndex = find(group.members.map{return $0.id}, self.receipt.creator.id)!
        namePicker.selectRow(payeeIndex, inComponent: 0, animated: true)
        
        payedByLabel = createLabel("Payee:")
        payedByTF = createTextField()
        payedByTF.addTarget(self, action: Selector("text:"), forControlEvents: UIControlEvents.EditingChanged)

        commentLabel = createLabel("Comment:")
        commentTF = createTextView()
        commentTF.delegate = self
        
        dateLabel = createLabel("Date:")
        dateTF = createTextField()
        
        amountLabel = createLabel("Amount:")
        amountTF = createTextField()
        amountTF.addTarget(self, action: Selector("textFieldChanged:"), forControlEvents: UIControlEvents.EditingChanged)
        
        saveButton = createSendButton()
        saveButton.addTarget(self, action: Selector("sendButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
 
        payedByTF.text = receipt.creator.name
        commentTF.text = receipt.comment
        dateTF.text = receipt.date.mediumPrintable()
        amountTF.text = receipt.amount.description
        
        view.addSubview(payedByLabel)
        view.addSubview(payedByTF)
        view.addSubview(commentLabel)
        view.addSubview(commentTF)
        view.addSubview(dateLabel)
        view.addSubview(dateTF)
        view.addSubview(amountLabel)
        view.addSubview(amountTF)
        view.addSubview(saveButton)
        
        let views:[NSObject:AnyObject] = ["payedBy":payedByTF,"comment":commentTF,"date":dateTF,"amount":amountTF, "payeeLabel":payedByLabel, "amountLabel":amountLabel, "dateLabel":dateLabel, "commentLabel":commentLabel, "saveButton":saveButton]

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[payeeLabel]-[payedBy]-[date]-[amount]-[commentLabel]-[comment]-[saveButton(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[payedBy]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[payeeLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[comment]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[commentLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: dateLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: dateTF, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[dateLabel(80)]-[date]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[amountLabel(80)]-[amount]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: amountLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: amountTF, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[saveButton(80)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return group.members.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return group.members[row].name
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == dateTF {
            textField.inputView = datePicker
        }
        
        if textField == payedByTF {
            textField.inputView = namePicker
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        payedByTF.text = group.members[row].name
        updateModel()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func updateModel(){
        receipt.creator = group.members[namePicker.selectedRowInComponent(0)]
        receipt.date = datePicker.date
        receipt.amount = (amountTF.text as NSString).doubleValue
        receipt.comment = commentTF.text
        
    }
    
    func textViewDidChange(textView: UITextView) {
        updateModel()
    }
    
    func textFieldChanged(tf:UITextField){
        updateModel()
    }
    
    func datePickerValueChanged(sender: UIDatePicker){
        var dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateTF.text = dateformatter.stringFromDate(sender.date)
        updateModel()
    }
    
    init(group:Group, receipt:Expense){
        super.init(nibName: nil, bundle: nil)
        self.receipt = receipt
        self.group = group
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLabel(text:String) -> UILabel{
        var label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = text
        return label
    }
    
    func createDatePicker() -> UIDatePicker {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        datePicker.date = receipt.date
        datePicker.maximumDate = NSDate()
        return datePicker
    }
    
    func createTextField() -> UITextField{
        var textField = UITextField()
        textField.delegate = self
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.placeholder = ""
        textField.textAlignment = NSTextAlignment.Center
        textField.keyboardType = UIKeyboardType.Default
        textField.returnKeyType = UIReturnKeyType.Done
        
        return textField
    }
    
    func createTextView() -> UITextView {
        var textView = UITextView()
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        textView.scrollEnabled = false
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        textView.layer.borderWidth = 1
        textView.font = createTextField().font
        return textView
    }
    
    func createSendButton() -> UIButton{
        var button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("Save", forState: .Normal)
        button.titleLabel!.font = UIFont(name:"Helvetica", size:30)
        return button
    }
    
    func sendButtonPressed(sender:UIButton!){
        //TODO display progress and verified completion
        ExpensesHandler().updateExpense(receipt)
    }
    
}