//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking

// MARK: - View
protocol ProductView: class {
    func updateTotalValue()
}

// MARK: - ViewModel
protocol ProductViewModel {
    
    var view: ProductView? { get set }
    
    var cartService: CartService { get }
    
    var restaurant: Restaurant { get }
    var originalProduct: Product { get }
    var product: Product { get set }
    var count: Int { get set }
    
    var availableChoices: [Choice] { get }
    
	func addToCart(onFailure: @escaping VoidClosure)
	func reloadCart()
}

// MARK: - Implementation
final class ProductViewModelImplementation: ProductViewModel {
    
    weak var view: ProductView?
    
    var cartService: CartService = AppDelegate.shared.context.cartService
    
    let restaurant: Restaurant
    let originalProduct: Product
    let availableChoices: [Choice]
    
    var product: Product
	
	var cartItem: CartItem {
		return CartItem(
			id: self.product.id,
			product: self.product,
			count: self.count,
			restId: self.restaurant.chainID
		)
	}
    
    var count: Int = 1 {
        didSet {
            product.productcount = self.count
        }
    }
    
    init(product: Product, restaurant: Restaurant) {
        self.restaurant = restaurant
        self.originalProduct = product
        self.product = product
        self.product.removeAllChoices()
        self.product.productcount = 1
        self.product.productcount = count
        
        self.availableChoices = product.options?.flatMap({ (option) -> [Choice] in
            option.choices
        }) ?? []
    }
	
	func addToCart(onFailure: @escaping VoidClosure) {
		cartService.addItem { [weak self] in
			guard let self = self else { return nil }
			if self.cartService.restaurant == nil {
				self.cartService.restaurant = self.restaurant
			}
			if (self.cartService.restaurant?.chainID ?? -1) == self.restaurant.chainID {
				return self.cartItem
			} else {
				onFailure()
				return nil
			}
		}
	}
	
	func reloadCart() {
		cartService.reload()
	}
    
}

extension Restaurant: CartRestaurantData {
	
	public var deliveryFee: Double {
		return Double(restDeliveryFee) ?? 0
	}
	
	public var isOpen: Bool {
		switch status {
		case .open:
			return true
		case .close:
			return false
		}
	}
	
}
