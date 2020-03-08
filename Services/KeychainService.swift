//
//  Created by Vladimir on 2/4/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import KeychainAccess
import Extensions

public protocol KeychainServiceHolder {
    
    var keychainSevice: KeychainService { get }
    
}

public enum KeychainItem: String {
    case authToken
    case JWTToken
    case email
    case creditCardNumber
    case creditCardMonth
    case creditCardYear
    case creditCardCVV
}

public protocol KeychainService {
    
    func setValueForItem(_ item: KeychainItem, _ value: String)
    func getValueForItem(_ item: KeychainItem) -> String?
    func removeValue(_ item: KeychainItem)
    func getCreditCardDetails() -> CreditCard?
    func updateCreditCardDetails(_ creditCard: CreditCard)
    func removeCardDetails()
    
}

public class KeychainServiceImplementation: KeychainService {
    
    var keychain: Keychain
    
    public init(identifier: String) {
        keychain = Keychain(service: identifier)
    }
    
    public func setValueForItem(_ item: KeychainItem, _ value: String) {
        keychain[item.rawValue] = value
    }
    
    public func getValueForItem(_ item: KeychainItem) -> String? {
        return keychain[item.rawValue]
    }
    
    public func removeValue(_ item: KeychainItem) {
        keychain[item.rawValue] = nil
    }
    
    public func getCreditCardDetails() -> CreditCard? {
        guard let number = getValueForItem(.creditCardNumber),
            let month = getValueForItem(.creditCardMonth),
            let year = getValueForItem(.creditCardYear),
            let cvv = getValueForItem(.creditCardCVV) else {
                return nil
        }
        return CreditCard(number: number, expirationDate: CreditCard.ExpirationDate(month: month, year: year), cvv: cvv)
    }
    
    public func removeCardDetails() {
        removeValue(.creditCardNumber)
        removeValue(.creditCardMonth)
        removeValue(.creditCardYear)
        removeValue(.creditCardCVV)
    }
    
    public func updateCreditCardDetails(_ creditCard: CreditCard) {
        setValueForItem(.creditCardNumber, creditCard.number)
        setValueForItem(.creditCardMonth, creditCard.expirationDate.month)
        setValueForItem(.creditCardYear, creditCard.expirationDate.year)
        setValueForItem(.creditCardCVV, creditCard.cvv)
    }
    
}

public struct CreditCard {
    
    public struct ExpirationDate {
        public let month: String
        public let year: String
        
        public init(month: String, year: String) {
            self.month = month
            self.year = year
        }
    }
    
    public let number: String
    public let expirationDate: ExpirationDate
    public let cvv: String
    public var isValid: Bool {
        return number.count == 16 &&
            expirationDate.month.count == 2 &&
            expirationDate.year.count == 2 &&
            cvv.count == 3
    }
    
    public init(number: String, expirationDate: CreditCard.ExpirationDate, cvv: String) {
        self.number = number
        self.expirationDate = expirationDate
        self.cvv = cvv
    }
    
    public static var empty: CreditCard {
        return CreditCard(number: "", expirationDate: CreditCard.ExpirationDate(month: "", year: ""), cvv: "")
    }
    
}
