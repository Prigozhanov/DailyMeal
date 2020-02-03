//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

class DynamicKey: CodingKey {
    
    var stringValue: String
    
    var intValue: Int?
    
    required init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    required init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}

// To handle response with single json key
public struct ResponseWrapper<Response: Codable>: Codable {
    
    public var data: Response?
    
    public init(from decoder: Decoder) {
        let values = try? decoder.container(keyedBy: DynamicKey.self)
        if let key = values?.allKeys.first(where: { $0.stringValue != "success" }) {
            data = try? values?.decode(Response.self, forKey: key)
        }
    }
    
}

// MARK: - Menu
struct MenuResponse: Codable {
    let restaurants: [Restaurant]
    let kitchens: [Kitchen]
    let allKitchenCategories: [AllKitchenCategory]
    
    enum CodingKeys: String, CodingKey {
        case restaurants, kitchens
        case allKitchenCategories = "all_kitchen_categories"
    }
}

// MARK: - AllKitchenCategory
struct AllKitchenCategory: Codable {
    let id, showInScroll: Int
    let image: String
    let position, showInApp: Int
    let alias: String
    let areaID: Int
    let label, title: String
    let count: Int
    let src: String
    let type: TypeEnum
    let restaurants: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case showInScroll = "show_in_scroll"
        case image, position
        case showInApp = "show_in_app"
        case alias
        case areaID = "area_id"
        case label, title, count, src, type, restaurants
    }
}

enum TypeEnum: String, Codable {
    case restaurant = "restaurant"
    case shop = "shop"
}

// MARK: - Kitchen
struct Kitchen: Codable {
    let id: Int
    let label, title, alias: String
    let count: Int
    let restaurants: [Int]
    let src: String
}

// MARK: - Restaurant
struct Restaurant: Codable {
    let id: Int
    let alias, image: String
    let additionalImageAPI: String?
    let rate, budget: String
    let new, minAmountOrder: Int
    let hash: String?
    let position: Int
    let restaurantChain: String
    let primaryInChain: Int
    let hasTakeaway: String
    let restaurantTakeawayTime, restaurantPrepTime, area: Int
    let mapMarker: String
    let chainCount: Int
    let latitude, longitude: Double
    let restDeliveryFee: String
    let mil1, mil2, mil3, mil4: Int
    let price1, price2, price3, price4: String
    let sponsored: String
    let sponsoredRestaurantTypesFlat: String
    let usePoligon, label, restaurantDescription, actionText: String
    let chainID: Int
    let chainLabel: String
    let totalHours: Int
    let openTime, closeTime: String
    let around: Int
    let altWorkHours: [AltWorkHour]
    let status: Status
    let statusLabel: StatusLabel
    let src: String
    let additionalImageAPISrc: String
    let sponsoredRestaurantTypes: [String: String]
    let type: TypeEnum
    let distance: Double
    let source: String
    let duration, distanceMetr, sortByMinutes: Double
    let orderDelayFirst, orderDelaySecond: Int
    let poligonMatch: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, alias, image
        case additionalImageAPI = "additional_image_api"
        case rate, budget, new
        case minAmountOrder = "min_amount_order"
        case hash, position
        case restaurantChain = "restaurant_chain"
        case primaryInChain = "primary_in_chain"
        case hasTakeaway = "has_takeaway"
        case restaurantTakeawayTime = "restaurant_takeaway_time"
        case restaurantPrepTime = "RestaurantPrepTime"
        case area
        case mapMarker = "map_marker"
        case chainCount = "chain_count"
        case latitude, longitude
        case restDeliveryFee = "rest_delivery_fee"
        case mil1 = "mil_1"
        case mil2 = "mil_2"
        case mil3 = "mil_3"
        case mil4 = "mil_4"
        case price1 = "price_1"
        case price2 = "price_2"
        case price3 = "price_3"
        case price4 = "price_4"
        case sponsored
        case sponsoredRestaurantTypesFlat = "sponsored_restaurant_types_flat"
        case usePoligon = "use_poligon"
        case label
        case restaurantDescription = "description"
        case actionText = "action_text"
        case chainID = "chain_id"
        case chainLabel = "chain_label"
        case totalHours, openTime, closeTime, around
        case altWorkHours = "alt_work_hours"
        case status
        case statusLabel = "status_label"
        case src
        case additionalImageAPISrc = "additional_image_api_src"
        case sponsoredRestaurantTypes = "sponsored_restaurant_types"
        case type, distance, source, duration, distanceMetr, sortByMinutes, orderDelayFirst, orderDelaySecond
        case poligonMatch = "poligon_match"
    }
}

// MARK: - AltWorkHour
struct AltWorkHour: Codable {
    let start, close: [String]
    let minutes: Int
}

enum Status: String, Codable {
    case close = "close"
    case statusOpen = "open"
}

enum StatusLabel: String, Codable {
    case mClose = "M_CLOSE"
    case mFullTime = "M_FULL_TIME"
    case mOpen = "M_OPEN"
}


public struct Category: Codable {
    public let id: Int?
    public let restaurantMenuCategories: Int?
    public let position: Int?
    public let alias: String?
    public let label: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case restaurantMenuCategories = "restaurant_menu_categories"
        case position = "position"
        case alias = "alias"
        case label = "label"
    }
}

// MARK: - Product
struct Product: Codable {
    let alias: String
    let menu, new, id: Int
    let label, imageTitle, content: String
    let itemNumber, inventory, restID, instock: Int
    let desiredStock: Int
    let price: String
    let restaurantMenuCategories: Int
    let image, type, keywords, readyTime: String
    let options: [Option]?
    let src: String
    
    enum CodingKeys: String, CodingKey {
        case alias, menu, new, id, label
        case imageTitle = "image_title"
        case content
        case itemNumber = "item_number"
        case inventory
        case restID = "rest_id"
        case instock
        case desiredStock = "desired_stock"
        case price
        case restaurantMenuCategories = "restaurant_menu_categories"
        case image, type, keywords
        case readyTime = "ready_time"
        case options, src
    }
}

// MARK: - Option
struct Option: Codable {
    let id, minimum, maximum: Int
    var active: Int
    let free, freemax, restaurantProducts, restaurant: Int
    let position: Int
    let optionTitle: String
    let lngID: Int
    let label: String
    let choices: [Choice]
    
    enum CodingKeys: String, CodingKey {
        case id, active, minimum, maximum, free, freemax
        case restaurantProducts = "restaurant_products"
        case restaurant, position
        case optionTitle = "option_title"
        case lngID = "lng_id"
        case label, choices
    }
}

// MARK: - Choice
struct Choice: Codable {
    let id, active, restaurantOptions: Int
    let price: String
    let position, nest, restaurant: Int
    let choiceOtherName: String
    let lngID: Int
    let label: String
    
    enum CodingKeys: String, CodingKey {
        case id, active
        case restaurantOptions = "restaurant_options"
        case price, position, nest, restaurant
        case choiceOtherName = "choice_other_name"
        case lngID = "lng_id"
        case label
    }
}

