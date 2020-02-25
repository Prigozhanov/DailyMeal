//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking

public enum FoodCategory: String, CaseIterable {
    
    case burger = "Burgers", chicken = "Chicken", desert = "Desserts", fries, hotdog = "Hot Dogs", lobastar, pizza = "Pizza", sandwich, steak = "Steak", sushi = "Sushi", taco, pasta = "Pasta", shawarma = "Shawarma", unknown
    
    var humanReadableValue: String {
        switch self {
        case .burger: return "Burgers"
        case .chicken: return "Chicken"
        case .desert: return "Deserts"
        case .fries: return "Fries"
        case .hotdog: return "Hotdog"
        case .lobastar: return "Lobstar"
        case .pizza: return "Pizza"
        case .sandwich: return "Sandwich"
        case .steak: return "Steak"
        case .sushi: return "Sushi"
        case .taco: return "Taco"
        case .pasta: return "Pasta"
        case .shawarma: return "Shaurma"
        case .unknown: return "Unknown"
        }
    }
    
    static func fromProductCategory(category: ProductCategory) -> FoodCategory? {
        return FoodCategory(rawValue: category.label.orEmpty.onlyLetters)
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
