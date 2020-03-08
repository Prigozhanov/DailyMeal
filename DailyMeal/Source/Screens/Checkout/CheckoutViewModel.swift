//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Services
import Networking

// MARK: - View
protocol CheckoutView: class {
    func onSuccessSubmit()
	func onFailedSubmit()
}

// MARK: - ViewModel
protocol CheckoutViewModel {
    
    var view: CheckoutView? { get set }
    
    var paymentMethod: PaymentMethod { get set }
    
    var creditCard: CreditCard? { get }
	
	var restaurant: RestaurantData? { get }
    
    func checkoutOrder()
}

// MARK: - Implementation
final class CheckoutViewModelImplementation: CheckoutViewModel {
    
    weak var view: CheckoutView?
    
    var context: AppContext
    var networkService: NetworkService
    var keychainService: KeychainService
    var cartService: CartService
    var userDefaultsService: UserDefaultsService
    
    var creditCard: CreditCard? {
        keychainService.getCreditCardDetails()
    }
    
    var paymentMethod: PaymentMethod = .cash
	
	lazy var restaurant: RestaurantData? = cartService.restaurant
    
    init() {
        context = AppDelegate.shared.context
        networkService = context.networkService
        keychainService = context.keychainSevice
        cartService = context.cartService
        userDefaultsService = context.userDefaultsService
    }
    
    func checkoutOrder() {
        let requestObject = ShoppingCartRequest(
            paymentMethods: paymentMethod.rawValue,
            yourNotes: "",
            memberID: userDefaultsService.getValueForKey(key: .id) as? Int ?? 0,
            intercom: "",
            phoneConfirm: 0,
            timeMinute: "09",
            fullname: "",
            addressID: userDefaultsService.getValueForKey(key: .addressesId) as? Int ?? 0,
            deliveryDate: Date().timeIntervalSince1970 + 3600,
            details: "",
            apartament: "",
            house: "",
            orderType: "",
            floor: "",
            recuringUserID: 0,
            restID: 0,
            deliveryDirtyLong: 0,
            coupon: "",
            deliveryType: "",
            deliveryAddress: userDefaultsService.getValueForKey(key: .addressName) as? String ?? "",
            deliveryDirtyLat: 0,
            delivery: "as_soon_as_possible",
            timeHour: "2",
            addressDetails: "",
            entrance: "",
            phone: userDefaultsService.getValueForKey(key: .phone) as? String ?? "",
            products: cartService.items.values.map({ $0.product }),
            usebonus: ""
        )
        
        let req = networkService.requestFactory.shoppingCart(shoppingCartRequest: requestObject)
		userDefaultsService.setValueForKey(key: .lastOrderId, value: "TEST")
		userDefaultsService.setValueForKey(key: .lastOrderDate, value: Date())
		userDefaultsService.setValueForKey(key: .lastOrderDeliveryTimeSeconds, value: (restaurant?.orderDelayFirst ?? 0) * 60)
		cartService.reload()
		view?.onSuccessSubmit()
//        networkService.send(request: req) { (result, _) in
//            switch result {
//            case let .success(response):
//                print(response)
//            case let .failure(error):
//                logDebug(message: error.localizedDescription)
//            }
//        }
    }
    
}
