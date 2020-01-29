//
//  Created by Vladimir on 1/28/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public class CartItem: Comparable, Equatable, NSCopying {
    var id: String
    var name: String
    var price: Double
    var count: Int
    var options: [Option]
    
    var overallPrice: Double {
        get {
            return self.price + self.appliedOptionsPrice
        }
    }
    
    private var appliedOptionsPrice: Double {
        return options.reduce(0.0) { (res, option) -> Double in
            option.applied ? res + option.price : res
        }
    }
    
    init(id: String, name: String, price: Double, options: [Option], count: Int = 1) {
        self.id = id
        self.name = name
        self.price = price
        self.options = options
        self.count = count
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return CartItem(id: self.id, name: self.name, price: self.price, options: self.options.map { $0.copy() as! Option }, count: self.count)
    }
    
    static var dummy: CartItem {
        return CartItem(id: "1", name: "Dummy Pizza", price: 42.99, options: [Option(option: .cheese, price: 5, applied: true), Option(option: .hot, price: 1.99, applied: true)], count: 3)
    }
    
    static var dummy1: CartItem {
        return CartItem(id: "2", name: "Dummy Pastry", price: 12.99, options:  [Option(option: .cheese, price: 0.99, applied: false), Option(option: .hot, price: 1.99, applied: false), Option(option: .petty, price: 1.5, applied: false), Option(option: .dummy, price: 3.99, applied: true)])
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
    
    public class Option: Comparable, Equatable, NSCopying {
        public let option: FoodOption
        public let price: Double
        public var applied: Bool
        
        init(option: FoodOption, price: Double, applied: Bool = false) {
            self.option = option
            self.price = price
            self.applied = applied
        }
        
        public func copy(with zone: NSZone? = nil) -> Any {
            return Option(option: self.option, price: self.price, applied: self.applied)
        }
        
        public static func < (lhs: CartItem.Option, rhs: CartItem.Option) -> Bool {
            return lhs.price < rhs.price
        }
        
        public static func == (lhs: CartItem.Option, rhs: CartItem.Option) -> Bool {
            return lhs.price == rhs.price &&
                lhs.option == rhs.option
        }
    }
}
