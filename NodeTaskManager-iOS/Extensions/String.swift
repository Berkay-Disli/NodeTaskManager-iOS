//
//  String.swift
//  Abonesepeti
//
//  Created by Marjan on 10/12/1400 AP.
//

import UIKit

extension Locale {
    static let englishUS: Locale = .init(identifier: "en_US")
    static let frenchFR: Locale = .init(identifier: "fr_FR")
    static let portugueseBR: Locale = .init(identifier: "pt_BR")
    static let turkishtr: Locale = .init(identifier: "tr")
    // ... and so on
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let phoneRegEx = #"^\d{10}$"#
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: self)
    }
    
    func stripOutHtml() -> String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func toTurkyMonthsTitle() -> String {
        let Jan = replacingOccurrences(of: "Jan", with: "Ocak")
        let Feb = Jan.replacingOccurrences(of: "Feb", with: "Şubat")
        let March = Feb.replacingOccurrences(of: "Mar", with: "Mart")
        let April = March.replacingOccurrences(of: "Apr", with: "Nisan")
        let May = April.replacingOccurrences(of: "May", with: "Mayıs")
        let June = May.replacingOccurrences(of: "Jun", with: "Haziran")
        let July = June.replacingOccurrences(of: "Jul", with: "Temmuz")
        let Aug = July.replacingOccurrences(of: "Aug", with: "Ağustos")
        let Sep = Aug.replacingOccurrences(of: "Sept", with: "Eylül")
        let Sep2 = Sep.replacingOccurrences(of: "Sep", with: "Eylül")
        let Oct = Sep2.replacingOccurrences(of: "Oct", with: "Ekim")
        let Nov = Oct.replacingOccurrences(of: "Nov", with: "Kasım")
        let Dec = Nov.replacingOccurrences(of: "Dec", with: "Aralık")
        
        return Dec
    }
    
    func toTurkyMonthsNumbers() -> String {
        let Jan = replacingOccurrences(of: "Jan", with: "01")
        let Feb = Jan.replacingOccurrences(of: "Feb", with: "02")
        let March = Feb.replacingOccurrences(of: "Mar", with: "03")
        let April = March.replacingOccurrences(of: "Apr", with: "04")
        let May = April.replacingOccurrences(of: "May", with: "05")
        let June = May.replacingOccurrences(of: "Jun", with: "06")
        let July = June.replacingOccurrences(of: "Jul", with: "07")
        let Aug = July.replacingOccurrences(of: "Aug", with: "08")
        let Sep = Aug.replacingOccurrences(of: "Sept", with: "09")
        let Sep2 = Sep.replacingOccurrences(of: "Sep", with: "09")
        let Oct = Sep2.replacingOccurrences(of: "Oct", with: "10")
        let Nov = Oct.replacingOccurrences(of: "Nov", with: "11")
        let Dec = Nov.replacingOccurrences(of: "Dec", with: "12")
        
        return Dec
    }
    
    var isBackspace: Bool {
        let char = cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
    /// - returns: a string has only 1 character
    func stringAt(index: Int) -> String {
        let stringIndex = self.index(startIndex, offsetBy: index)
        return String(self[stringIndex])
    }
    
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespaces() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: self)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    func resetFormattedPhoneNumber() -> String {
        return self.replacingOccurrences(of: " ", with: "")
                             .replacingOccurrences(of: "(", with: "")
                             .replacingOccurrences(of: ")", with: "")
    }
    
    func currencyFormatOnFormattedPrice() -> String {
        return "\(self) ₺"
    }

}
