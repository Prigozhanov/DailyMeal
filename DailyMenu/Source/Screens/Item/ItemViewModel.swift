//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol ItemView: class {
    func updateTotalValue()
}

//MARK: - ViewModel
protocol ItemViewModel {
    
    var view: ItemView? { get set }
    
    var cartService: CartService { get }
    
    var restaurant: Restaurant { get }
    var item: Product { get }
    var count: Int { get set }
    
    
}

//MARK: - Implementation
final class ItemViewModelImplementation: ItemViewModel {
    
    weak var view: ItemView?
    
    var cartService: CartService = AppDelegate.shared.context.cartService
    
    let restaurant: Restaurant
    let item: Product
    var count: Int = 1
    
    init(item: Product, restaurant: Restaurant) {
        self.restaurant = restaurant
        self.item = item
    }
    
}


