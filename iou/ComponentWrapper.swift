//
// Created by Knut Nygaard on 01/03/16.
// Copyright (c) 2016 APM solutions. All rights reserved.
//

import Foundation
import UIKit

class ComponentWrapper {

    let view:UIView!
    let rules:ConstraintRules!

    init(view:UIView, rules:ConstraintRules){
        self.view = view
        self.rules = rules
    }
}
