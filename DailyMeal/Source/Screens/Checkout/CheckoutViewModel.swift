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
    
	var paymentMethod: PaymentMethod {
		didSet {
			userDefaultsService.setValueForKey(key: .paymentMethod, value: paymentMethod.rawValue)
		}
	}
	
	lazy var restaurant: RestaurantData? = cartService.restaurant
    
    init() {
        context = AppDelegate.shared.context
        networkService = context.networkService
        keychainService = context.keychainSevice
        cartService = context.cartService
        userDefaultsService = context.userDefaultsService
		
		if let paymentMethodValue = userDefaultsService.getValueForKey(key: .paymentMethod) as? Int {
			paymentMethod = PaymentMethod(rawValue: paymentMethodValue) ?? .cash
		} else {
			paymentMethod = .cash
		}
    }
    
    func checkoutOrder() {
        let requestObject = ShoppingCartRequest(
            paymentMethods: paymentMethod.rawValue,
            yourNotes: "",
            memberID: userDefaultsService.getValueForKey(key: .id) as? Int ?? 0,
            intercom: "",
            phoneConfirm: 0,
            timeMinute: "09", // Don't know what this value mean. Just leave it as is. It should work :)
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
	
        networkService.send(request: req) { [weak self] result, _ in
            switch result {
            case let .success(response):
				self?.userDefaultsService.setValueForKey(key: .lastOrderId, value: response.rawResponse.orderID)
				self?.userDefaultsService.setValueForKey(key: .lastOrderDate, value: Date())
				self?.userDefaultsService.setValueForKey(key: .lastOrderDeliveryTimeSeconds, value: (self?.restaurant?.orderDelayFirst ?? 0) * 60)
				self?.cartService.reload()
				self?.view?.onSuccessSubmit()
            case let .failure(error):
				self?.view?.onFailedSubmit()
                logDebug(message: error.localizedDescription)
            }
        }
    }
    
}
