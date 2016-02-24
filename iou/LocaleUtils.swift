
import Foundation

func localeStringFromNumber(locale:NSLocale, number:Double) -> String {
    let formatter:NSNumberFormatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    formatter.locale = locale

    return formatter.stringFromNumber(number)!
}

func localeNumberFromString(string:String) -> Double{
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .DecimalStyle
    return formatter.numberFromString(string)!.doubleValue
}


