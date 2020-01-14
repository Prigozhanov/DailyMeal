//
//  Created by Vladimir on 1/13/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public protocol CartServiceHolder {
    var cartService: CartService { get }
}

public protocol CartService {
    var items: [CartItem] { get }
    
    var cartTotal: Double { get }
    var tax: Double { get }
    var deliveryPrice: Double { get }
    var promoDiscount: Double { get }
    
    var subtotal: Double { get }
    
    func addItem(item: CartItem)
    func removeItem(item: CartItem)
}

public final class CartServiceImplementation: CartService {
    
    public var cartTotal: Double {
        return items.reduce(0.0) { (res, item: CartItem) -> Double in
            res + item.price * Double(item.count)
        }
    }
    
    public var tax: Double = 0.0
    
    public var deliveryPrice: Double = 0.0
    
    public var promoDiscount: Double = 0.0
    
    public var subtotal: Double {
        return cartTotal + tax + deliveryPrice + promoDiscount
    }
    
    public func addItem(item: CartItem) {
        
    }
    
    public func removeItem(item: CartItem) {
        items.removeAll { (localItem) -> Bool in
            item == localItem
        }
    }
    
    public var items: [CartItem] = [CartItem.dummy, CartItem.dummy1]
}


public class CartItem: Comparable, Equatable {
    var name: String
    var price: Double
    var count: Int
    var options: [FoodOptions]
    
    init(name: String, price: Double, options: [FoodOptions], count: Int = 1) {
        self.name = name
        self.price = price
        self.options = options
        self.count = count
    }
    
    public static func < (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.price < rhs.price
    }
    
    public static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.name == rhs.name &&
            lhs.price == rhs.price &&
            lhs.options == rhs.options
    }
    
    static var dummy: CartItem {
        return CartItem(name: "Dummy Pizza", price: 42.99, options: [.cheese, .petty], count: 3)
    }
    
    static var dummy1: CartItem {
        return CartItem(name: "Dummy Pastry", price: 42.99, options: [.cheese, .petty, .hot])
    }
}
