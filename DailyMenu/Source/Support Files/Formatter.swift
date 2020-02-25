//
//  Created by Vladimir on 1/14/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

enum Formatter {
    
    static func getHighlightedAttributtedString(string: String,
                                                keyWord: String,
                                                font: UIFont,
                                                highlightingFont: UIFont,
                                                highlightingColor: UIColor? = nil) -> NSAttributedString {
        let range = (string as NSString).range(of: keyWord, options: [.caseInsensitive])
        let attrString = NSMutableAttributedString(
            string: string, attributes: [.font: font]
        )
        attrString.addAttributes([.font: highlightingFont], range: range)
        if let highlightingColor = highlightingColor {
            attrString.addAttributes([.foregroundColor: highlightingColor], range: range)
        }
        return attrString
    }
    
    // MARK: - Currency
    enum Currency {
        static func toString(_ string: String) -> String {
            guard let value = fromString(string) else {
                return "Error"
            }
            return toString(value)
        }
        
        static func toString(_ value: Double?) -> String {
            guard let value = value else {
                return "Error"
            }
            return value < 0 ? String(format: "- BYN %.2f", abs(value)) : String(format: "BYN %.2f", value)
        }
        
        static func toString(_ value: Int?) -> String {
            guard let value = value else {
                return "Error"
            }
            return value < 0 ? "- BYN \(abs(value))" : "BYN \(value)"
        }
        
        static func fromString(_ string: String?) -> Double? {
            guard let string = string else {
                return nil
            }
            return Double(string)
        }
    }
    
    // MARK: - Distance
    enum Distance {
        static func toString(_ value: Double) -> String {
            return String(format: "%.1f km", value)
        }
    }
    
    // MARK: - CreditCard
    enum CreditCard {
        static func hiddenNumber(string: String?) -> String? {
            if let string = string, string.count == 16 {
                return "**** **** **** \(string.suffix(4))"
            } else {
                return nil
            }
        }
        
        static func shouldChange(string: String, maxCharacters: Int) -> Bool {
            return string.count < maxCharacters + 1 && string.isNumber
        }
    }
    
    // MARK: - PhoneNumber
    enum PhoneNumber {
        static func formattedString(_ string: String?) -> String? {
            guard let string = string, !string.contains("+") else {
                return nil
            }
            return string.replacingOccurrences(of: string, with: "+\(string)")
        }
        
        static func shouldChange(string: String?, maxCharacters: Int) -> Bool {
            guard let string = string else {
                return false
            }
            return string.count < maxCharacters + 1 && string.isNumber
        }
        
        static func isValid(string: String) -> Bool {
            return string.starts(with: "+") &&
                CharacterSet.decimalDigits.isSuperset(of: CharacterSet(
                    charactersIn: string.replacingOccurrences(of: "+", with: "")
                ))
        }
        
    }
    
    enum Email {
        static func isValid(string: String) -> Bool {
            guard CharacterSet
                .alphanumerics
                .union(CharacterSet(charactersIn: "-.@"))
                .isSuperset(of: CharacterSet(charactersIn: string)) else {
                    return false
            }
            
            guard string.contains("@"), string.split(separator: "@")[1].contains(".") else {
                return false
            }
            
            return true
        }
    }
}
