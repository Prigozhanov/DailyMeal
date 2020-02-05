//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Services

//MARK: - View
protocol CheckoutView: class {
    
}

//MARK: - ViewModel
protocol CheckoutViewModel {
    
    var view: CheckoutView? { get set }
    
    var paymentMethod: PaymentMethod? { get set }
    
    var creditCard: CreditCard? { get }
    
}

//MARK: - Implementation
final class CheckoutViewModelImplementation: CheckoutViewModel {
    
    weak var view: CheckoutView?
    
    var context: AppContext
    var keychainService: KeychainService
    
    var creditCard: CreditCard?
    
    var paymentMethod: PaymentMethod?
    
    init() {
        context = AppDelegate.shared.context
        keychainService = context.keychainSevice
        
        creditCard = keychainService.getCreditCardDetails()
    }
    
}


