
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


