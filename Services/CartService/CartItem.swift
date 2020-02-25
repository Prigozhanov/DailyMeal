//
//  Created by Vladimir on 1/28/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import Networking

public class CartItem: Comparable, Equatable {
    var id: Int
    var product: Product
    var count: Int
    
    init(id: Int, product: Product, count: Int = 1) {
        self.id = id
        self.product = product
        self.count = count
    }
    
    var overallPrice: Double {
        product.overallPrice
    }
    
    public static func < (lhs: CartItem, rhs: CartItem) -> Bool {
        return (Double(lhs.product.price) ?? 0) < (Double(rhs.product.price) ?? 0)
    }
    
    public static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.id == rhs.id &&
            (Double(lhs.product.price) ?? 0) == (Double(rhs.product.price) ?? 0)
    }
    
}
