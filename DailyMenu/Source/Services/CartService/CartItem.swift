//
//  Created by Vladimir on 1/28/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public class CartItem: Comparable, Equatable, NSCopying {
    var id: Int
    var categoryId: Int
    var restaurantId: Int
    var name: String
    var price: Double
    var description: String?
    var count: Int
    var imageURL: String?
    var options: [Option]
    
    var overallPrice: Double {
        get {
            return price + appliedOptionsPrice
        }
    }
    
    private var appliedOptionsPrice: Double {
        return options.reduce(0.0) { (res, option) -> Double in
            option.applied ? res + option.price : res
        }
    }
    
    init(id: Int, categoryId: Int, restaurantId: Int, name: String, price: Double, description: String?, imageURL: String?, options: [Option], count: Int = 1) {
        self.id = id
        self.categoryId = categoryId
        self.restaurantId = restaurantId
        self.name = name
        self.price = price
        self.description = description
        self.imageURL = imageURL
        self.options = options
        self.count = count
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return CartItem(id: self.id, categoryId: self.categoryId, restaurantId: self.restaurantId, name: self.name, price: self.price, description: self.description, imageURL: self.imageURL, options: self.options.map { $0.copy() as! Option }, count: self.count)
    }
    
    static var dummy: CartItem {
        return CartItem(id: 1, categoryId: 0, restaurantId: 0, name: "Dummy Pizza", price: 42.99, description: "Dummy", imageURL: nil, options: [Option(option: .cheese, price: 5, applied: true), Option(option: .hot, price: 1.99, applied: true), Option(option: .hot, price: 1.99, applied: true), Option(option: .hot, price: 1.99, applied: true), Option(option: .hot, price: 1.99, applied: true)], count: 3)
    }
    
    static var empty: CartItem {
        return CartItem(id: -1, categoryId: -1, restaurantId: -1, name: "", price: 0, description: "", imageURL: nil, options: [])
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
    
    static func fromProduct(_ product: Product, count: Int = 1) -> CartItem? {
        guard let price = Double(product.price) else { return nil }
        return CartItem(id: product.id, categoryId: product.restaurantMenuCategories, restaurantId: product.restID, name: product.label, price: price, description: product.content, imageURL: product.src, options: [], count: count)
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
