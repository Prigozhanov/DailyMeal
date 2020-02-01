//
//  Created by Vladimir on 1/13/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public protocol CartView: AnyObject {
    func reloadCalculationsRows()
}

public protocol CartServiceHolder {
    var cartService: CartService { get }
}

public protocol CartService {
    
    var view: CartView? { get set }
    
    var items: [Int: CartItem] { get }
    
    var cartTotal: Double { get }
    var tax: Double { get }
    var deliveryPrice: Double { get }
    var promoDiscount: Double { get }
    
    var subtotal: Double { get }
    
    func addItem(item: CartItem)
    func removeItem(item: CartItem)
    func removeOption(option: CartItem.Option, atIndex index: Int, fromItem item: CartItem)
    
}

public final class CartServiceImplementation: CartService {
    
    public weak var view: CartView?
    
    public var cartTotal: Double {
        return items.values.reduce(0.0) { (res, item: CartItem) -> Double in
            res + item.overallPrice * Double(item.count)
        }
    }
    
    public var tax: Double = 0.0
    
    public var deliveryPrice: Double = 0.0
    
    public var promoDiscount: Double = 0.0
    
    public var subtotal: Double {
        return cartTotal + tax + deliveryPrice + promoDiscount
    }

    public var items: [Int: CartItem] = [:]
    
    public func addItem(item: CartItem) {
        items[item.id] = item
    }
    
    public func removeItem(item: CartItem) {
        items.removeValue(forKey: item.id)
    }
    
    public func removeOption(option: CartItem.Option, atIndex index: Int, fromItem item: CartItem) {
        items[item.id]?.options.remove(at: index)
    }
}
