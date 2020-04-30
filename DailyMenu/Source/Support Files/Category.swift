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
	
	// This conversion is necessary for comparison categories with localized back-end data.
	// Use this for comparing with back-end data instead of rawValue.
	var compatibleValue: String {
		switch self {
		case .burger: return Localizable.Categories.Compatible.burger
		case .chicken: return Localizable.Categories.Compatible.chicken
		case .desert: return Localizable.Categories.Compatible.desert
		case .fries: return Localizable.Categories.Compatible.fries
		case .hotdog: return Localizable.Categories.Compatible.hotdog
		case .lobastar: return Localizable.Categories.Compatible.lobstar
		case .pizza: return Localizable.Categories.Compatible.pizza
		case .sandwich: return Localizable.Categories.Compatible.sandwich
		case .steak: return Localizable.Categories.Compatible.steak
		case .sushi: return Localizable.Categories.Compatible.sushi
		case .taco: return Localizable.Categories.Compatible.taco
		case .pasta: return Localizable.Categories.Compatible.pasta
		case .shawarma: return Localizable.Categories.Compatible.shaurma
		case .unknown: return Localizable.Categories.Compatible.unknown
		}
	}
    
    static func fromProductCategory(category: ProductCategory) -> FoodCategory? {
		let category = category.label.orEmpty.onlyLetters
		
		if let compatibleValue = FoodCategory.allCases.first(
			where: { category.containsCaseIgnoring($0.compatibleValue) }
			) {
			return compatibleValue
		}
		return nil
    }
    
    static func getMainCategoryBasedOnRestaurantCategories(_ categories: [ProductCategory]) -> FoodCategory {
		if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.burger.compatibleValue) ?? false }) { return .burger }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.pizza.compatibleValue) ?? false }) { return .pizza }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.sushi.compatibleValue) ?? false }) { return .sushi }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.chicken.compatibleValue) ?? false }) { return .chicken }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.hotdog.compatibleValue) ?? false }) { return .hotdog }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.lobastar.compatibleValue) ?? false }) { return .lobastar }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.shawarma.compatibleValue) ?? false }) { return .shawarma }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.pasta.compatibleValue) ?? false }) { return .pasta }
        if categories.contains(where: { $0.label?.containsCaseIgnoring(FoodCategory.desert.compatibleValue) ?? false }) { return .desert }
        return .unknown
    }
    
}

public enum FoodOption: String {
    case cheese = "Cheese", petty = "Petty", hot = "Hot", dummy = "Dummy"
}
