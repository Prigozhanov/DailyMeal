//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking

public enum FoodCategory: String {
    case burger = "Burgers", chicken, desert = "Desserts", fries, hotdog = "Hot Dogs", lobastar, pizza, sandwich, steak, sushi, taco, pasta, shawarma, unknown
    
    static func fromCategory(category: ProductCategory) -> FoodCategory {
        return FoodCategory(rawValue: category.label.orEmpty.onlyLetters) ?? .unknown
    }
    
    static func getMainCategoryBasedOnRestaurantCategories(_ categories: [ProductCategory]) -> FoodCategory {
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.burger.rawValue) ?? false }) { return .burger }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.pizza.rawValue) ?? false }) { return .pizza }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.sushi.rawValue) ?? false }) { return .sushi }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.chicken.rawValue) ?? false }) { return .chicken }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.hotdog.rawValue) ?? false }) { return .hotdog }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.lobastar.rawValue) ?? false }) { return .lobastar }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.shawarma.rawValue) ?? false }) { return .shawarma }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.pasta.rawValue) ?? false }) { return .pasta }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.desert.rawValue) ?? false }) { return .desert }
        return .unknown
    }
}

public enum FoodOption: String {
    case cheese = "Cheese", petty = "Petty", hot = "Hot", dummy = "Dummy"
}
