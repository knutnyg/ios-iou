//
// Created by Knut Nygaard on 25/10/15.
// Copyright (c) 2015 APM solutions. All rights reserved.
//

import Foundation

func localeFormattedNumber(locale:NSLocale, number:Double) -> String {
    let formatter:NSNumberFormatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    formatter.locale = locale

    return formatter.stringFromNumber(number)!
}

func localeFormattedString(string:String) -> Double{
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .DecimalStyle
    return formatter.numberFromString(string)!.doubleValue
}


