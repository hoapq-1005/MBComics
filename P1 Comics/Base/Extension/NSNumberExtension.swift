//
//  AppDelegate.swift
//  TEnglish
//
//  Created by HoaPQ on 4/14/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension Int {
    func toCurrencyFormat(locale: Locale = Locale.current) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = locale
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        let str = numberFormatter.string(from: NSNumber(value: self)) ?? ""
        let arr = str.split(separator: ",")
        return String(arr[0])
    }
    
    func toFormat(separator: String = ",") -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = separator
        formatter.numberStyle = .decimal
        let str = formatter.string(from: NSNumber(value: self)) ?? ""
        return str
    }
    
    func toSpellString(locale: String = "vi_VN") -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = Locale(identifier: locale)
        let text = formatter.string(from: NSNumber(value: self))
        return text
    }
}
