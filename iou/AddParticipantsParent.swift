//
// Created by Knut Nygaard on 18/11/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation
import SnapKit

enum Type {
    case NEW
    case UPDATE
}

class AddParticipantsParent: UIViewController {

    var addParticipantTableView: AddParticipantsToExpenseTableViewController!
    var sendButton: UIButton!
    var expense: Expense!
    var delegate: GroupViewController!
    var type:Type!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()

        addParticipantTableView = AddParticipantsToExpenseTableViewController()
        addParticipantTableView.expense = expense
        addParticipantTableView.group = delegate.group
        sendButton = createButton("Send", font: UIFont(name: "HelveticaNeue", size: 20)!)
        sendButton.addTarget(self, action: "sendButtonPressed:", forControlEvents: .TouchUpInside)

        addChildViewController(addParticipantTableView)
        view.addSubview(addParticipantTableView.view)
        view.addSubview(sendButton)

        sendButton.snp_makeConstraints {
            (button) -> Void in
            button.bottom.equalTo(self.view.snp_bottom).offset(-20)
            button.right.equalTo(self.view.snp_right).offset(-20)
        }

        var tableHeight = delegate.group.members.count * 100 + 100

        if tableHeight > 700 {
            tableHeight = 700
        }

        addParticipantTableView.view.snp_makeConstraints {
            (make) -> Void in
            make.height.equalTo(tableHeight)
            make.width.equalTo(self.view.snp_width)
        }
    }

    func sendButtonPressed(sender: UIButton) {
        expense.participants = addParticipantTableView.selectedMembers
        
        switch type! {
        case .NEW:
            API.newExpense(expense)
                .onSuccess {
                    expense in
                    self.navigationController?.popToViewController(self.delegate, animated: true)
                }
                .onFailure {
                    err in
                    print(err)
            }
            break
        case .UPDATE:
            API.putExpense(expense)
                .onSuccess{ expense in
                    self.navigationController?.popToViewController(self.delegate, animated: true)
                }
                .onFailure{err in print(err)}
            break
        }
    }

}
