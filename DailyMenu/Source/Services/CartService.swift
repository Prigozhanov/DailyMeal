//
//  Created by Vladimir on 1/13/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public protocol CartServiceHolder {
    var cartService: CartService { get }
}

public protocol CartService {
    var items: [String: CartItem] { get }
    
    var cartTotal: Double { get }
    var tax: Double { get }
    var deliveryPrice: Double { get }
    var promoDiscount: Double { get }
    
    var subtotal: Double { get }
    
    func addItem(item: CartItem)
    func removeItem(item: CartItem)
    func removeOption(option: FoodOption, atIndex index: Int, fromItem item: CartItem)
}

public final class CartServiceImplementation: CartService {
    
    public var cartTotal: Double {
        return items.values.reduce(0.0) { (res, item: CartItem) -> Double in
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
        items.removeValue(forKey: item.id)
    }
    
    public func removeOption(option: FoodOption, atIndex index: Int, fromItem item: CartItem) {
        items[item.id]?.options.remove(at: index)
    }
    
    public var items: [String: CartItem] = [CartItem.dummy.id: CartItem.dummy, CartItem.dummy1.id: CartItem.dummy1]
}


public class CartItem: Comparable, Equatable {
    var id: String
    var name: String
    var price: Double
    var count: Int
    var options: [FoodOption]
    
    init(id: String, name: String, price: Double, options: [FoodOption], count: Int = 1) {
        self.id = id
        self.name = name
        self.price = price
        self.options = options
        self.count = count
    }
    
    public static func < (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.price < rhs.price
    }
    
    public static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.price == rhs.price &&
            lhs.options == rhs.options
    }
    
    public func removeOption(at index: Int) {
        options.remove(at: index)
    }
    
    static var dummy: CartItem {
        return CartItem(id: "1", name: "Dummy Pizza", price: 42.99, options: [.cheese, .petty], count: 3)
    }
    
    static var dummy1: CartItem {
        return CartItem(id: "2", name: "Dummy Pastry", price: 42.99, options: [.cheese, .petty, .hot, .petty])
    }
}
