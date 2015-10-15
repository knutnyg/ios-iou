//
//  ExpenseList.swift
//  iou
//
//  Created by Knut Nygaard on 15/10/15.
//  Copyright © 2015 APM solutions. All rights reserved.
//

import Foundation
import JSONJoy

class ExpenseList : JSONJoy {
    
    var expenses:[Expense]!
    
    
    init(expenses:[Expense]){
        self.expenses = expenses
    }
    
    required init(_ decoder: JSONDecoder) {
        if let g = decoder["receipts"].array {
            expenses = []
            for expensesDecoder in g {
                expenses.append(Expense(expensesDecoder))
            }
        }
    }
    
}