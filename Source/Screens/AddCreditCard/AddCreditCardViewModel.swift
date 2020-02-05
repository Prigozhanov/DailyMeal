//
//  AddCreditCardViewModel.swift
//

import Foundation
import Services

//MARK: - View
protocol AddCreditCardView: class {
    
}

//MARK: - ViewModel
protocol AddCreditCardViewModel {
    
    var view: AddCreditCardView? { get set }
    
    func saveCreditCardDetails(number: String, month: String, year: String, cvv: String)
    
    var isValid: Bool { get }
    
}

//MARK: - Implementation
final class AddCreditCardViewModelImplementation: AddCreditCardViewModel {
    
    weak var view: AddCreditCardView?
    
    let context: AppContext
    let keychainService: KeychainService
    
    private var creditCard: CreditCard?
    
    var isValid: Bool {
        return creditCard?.isValid ?? false
    }
    
    init() {
        context = AppDelegate.shared.context
        keychainService = context.keychainSevice
    }
    
    func saveCreditCardDetails(number: String, month: String, year: String, cvv: String) {
        creditCard = CreditCard(
            number: number,
            expirationDate: CreditCard.ExpirationDate(
                month: month,
                year: year
            ),
            cvv: cvv)
        if let creditCard = creditCard, creditCard.isValid {
            keychainService.updateCreditCardDetails(creditCard)
        }
    }
    
}


