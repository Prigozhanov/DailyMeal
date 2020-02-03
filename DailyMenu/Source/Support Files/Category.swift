//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

public enum FoodCategory: String {
    case burger = "Burgers", chicken, desert = "Desserts", fries, hotdog, lobastar, pizza, sandwich, steak, sushi, taco, pastry, unknown
    
    static func fromCategory(category: Category) -> FoodCategory {
        return FoodCategory(rawValue: category.label.orEmpty.onlyLetters) ?? .unknown
    }
    
    static func getMainCategoryBasedOnRestaurantCategories(_ categories: [FoodCategory]) -> FoodCategory {
        if categories.contains(.burger) { return .burger }
        if categories.contains(.chicken) { return .chicken }
        if categories.contains(.desert) { return .desert }
        if categories.contains(.fries) { return .fries }
        if categories.contains(.hotdog) { return .hotdog }
        if categories.contains(.lobastar) { return .lobastar }
        return .unknown
    }
}

public enum FoodOption: String {
    case cheese = "Cheese", petty = "Petty", hot = "Hot", dummy = "Dummy"
}
