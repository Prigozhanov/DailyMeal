//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking

//MARK: - View
protocol ProductView: class {
    func updateTotalValue()
}

//MARK: - ViewModel
protocol ProductViewModel {
    
    var view: ProductView? { get set }
    
    var cartService: CartService { get }
    
    var restaurant: Restaurant { get }
    var product: Product { get }
    var count: Int { get set }
    
    
}

//MARK: - Implementation
final class ProductViewModelImplementation: ProductViewModel {
    
    weak var view: ProductView?
    
    var cartService: CartService = AppDelegate.shared.context.cartService
    
    let restaurant: Restaurant
    let product: Product
    var count: Int = 1
    
    init(product: Product, restaurant: Restaurant) {
        self.restaurant = restaurant
        self.product = product
    }
    
}


