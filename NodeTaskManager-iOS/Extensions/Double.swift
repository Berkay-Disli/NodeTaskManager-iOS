//
//  Double.swift
//  Abonesepeti
//
//  Created by İbrahim Demirci on 7.03.2023.
//

import Foundation

extension Double {
    func currencyFormattingWithLira() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.turkishtr
        formatter.currencySymbol = ""
        // formatter.currencyGroupingSeparator = "."
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        if let str = formatter.string(for: self) {
            return str + " TL"
        }
        return ""
    }

    // formatting text for currency textField
    func currencyFormatting() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.turkishtr
        formatter.currencySymbol = ""
        // formatter.currencyGroupingSeparator = "."
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        if let str = formatter.string(for: self) {
            return str
        }
        return ""
    }
}
