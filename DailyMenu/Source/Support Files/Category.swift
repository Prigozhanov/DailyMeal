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
		case .burger: return Localizable.Categories.burger
		case .chicken: return Localizable.Categories.chicken
		case .desert: return Localizable.Categories.desert
		case .fries: return Localizable.Categories.fries
		case .hotdog: return Localizable.Categories.hotdog
		case .lobastar: return Localizable.Categories.lobstar
		case .pizza: return Localizable.Categories.pizza
		case .sandwich: return Localizable.Categories.sandwich
		case .steak: return Localizable.Categories.steak
		case .sushi: return Localizable.Categories.sushi
		case .taco: return Localizable.Categories.taco
		case .pasta: return Localizable.Categories.pasta
		case .shawarma: return Localizable.Categories.shaurma
		case .unknown: return Localizable.Categories.unknown
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


