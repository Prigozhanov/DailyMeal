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

public struct Empty: Codable {}

// To handle response with single json key
public struct SingleKeyResponseWrapper<Response: Codable>: Codable {
    
    public var data: Response?
    
    public init(from decoder: Decoder) {
        let values = try? decoder.container(keyedBy: DynamicKey.self)
        if let key = values?.allKeys.first(where: { $0.stringValue != "success" }) {
            data = try? values?.decode(Response.self, forKey: key)
        }
    }
    
}

public struct ResponseWrapper<WrappedData: Codable>: Codable {
    public let code: Int?
    public let message: String?
    public let data: WrappedData?
}

// MARK: - User
//TODO: some fields are missing in this structure, see menu.by response to add them then
public struct User: Codable {
    public let id: Int
    public let fullname, name, lastname, companyName: String
    public let email, phone, remberMe: String
    public let status, bonus: Int
    public let regDate: String
    public let indms, hasRecuringCard: Int
    public let recurringCardDate: String
    public let selectedArea: Int
    public let isTester, isCorporateUser, phoneVerify, emailVerify: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullname, name, lastname
        case companyName = "company_name"
        case email, phone
        case remberMe = "rember_me"
        case status, bonus
        case regDate = "reg_date"
        case indms
        case hasRecuringCard = "has_recuring_card"
        case recurringCardDate = "recurring_card_date"
        case selectedArea = "selected_area"
        case isTester = "is_tester"
        case isCorporateUser = "is_corporate_user"
        case phoneVerify = "phone_verify"
        case emailVerify = "email_verify"
    }
}

// MARK: - VerifyToken
public struct LoginResponse: Codable {
    public let member: User?
    public let success: Bool?
    public let message, jwtToken: String?
    public let token: String?
    public let responseCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case member, success, message
        case jwtToken = "JWTToken"
        case token, responseCode
    }
}

// MARK: - DataClass
public struct PushRegistration: Codable {
    public let registrationID, deviceName, devicePlatform, deviceUUID: String
    public let appVersion: String
    public let memberID: Int
    public let lng, method, updatedAt, createdAt: String
    public let id: Int
    
    enum CodingKeys: String, CodingKey {
        case registrationID = "registrationId"
        case deviceName = "device_name"
        case devicePlatform = "device_platform"
        case deviceUUID = "device_uuid"
        case appVersion = "app_version"
        case memberID = "member_id"
        case lng, method
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

// MARK: - Menu
public struct MenuResponse: Codable {
    public let restaurants: [Restaurant]
    public let kitchens: [Kitchen]
    public let allKitchenCategories: [AllKitchenCategory]
    
    enum CodingKeys: String, CodingKey {
        case restaurants, kitchens
        case allKitchenCategories = "all_kitchen_categories"
    }
}

// MARK: - AllKitchenCategory
public struct AllKitchenCategory: Codable {
    public let id, showInScroll: Int
    public let image: String
    public let position, showInApp: Int
    public let alias: String
    public let areaID: Int
    public let label, title: String
    public let count: Int
    public let src: String
    public let type: TypeEnum
    public let restaurants: [Int]
    
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

public enum TypeEnum: String, Codable {
    case restaurant = "restaurant"
    case shop = "shop"
}

// MARK: - Kitchen
public struct Kitchen: Codable {
    public let id: Int
    public let label, title, alias: String
    public let count: Int
    public let restaurants: [Int]
    public let src: String
}

// MARK: - Restaurant
public struct Restaurant: Codable {
    public let id: Int
    public let alias, image: String
    public let additionalImageAPI: String?
    public let rate, budget: String
    public let new, minAmountOrder: Int
    public let hash: String?
    public let position: Int
    public let restaurantChain: String
    public let primaryInChain: Int
    public let hasTakeaway: String
    public let restaurantTakeawayTime, restaurantPrepTime, area: Int
    public let mapMarker: String
    public let chainCount: Int
    public let latitude, longitude: Double
    public let restDeliveryFee: String
    public let mil1, mil2, mil3, mil4: Int
    public let price1, price2, price3, price4: String
    public let sponsored: String
    public let sponsoredRestaurantTypesFlat: String
    public let usePoligon, label, restaurantDescription, actionText: String
    public let chainID: Int
    public let chainLabel: String
    public let totalHours: Int
    public let openTime, closeTime: String
    public let around: Int
    public let altWorkHours: [AltWorkHour]
    public let status: Status
    public let statusLabel: StatusLabel
    public let src: String
    public let additionalImageAPISrc: String
    public let sponsoredRestaurantTypes: [String: String]
    public let type: TypeEnum
    public let distance: Double
    public let source: String
    public let duration, distanceMetr, sortByMinutes: Double
    public let orderDelayFirst, orderDelaySecond: Int
    public let poligonMatch: Bool?
    
    public enum CodingKeys: String, CodingKey {
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
public struct AltWorkHour: Codable {
    public let start, close: [String]
    public let minutes: Int
}

public enum Status: String, Codable {
    case close = "close"
    case statusOpen = "open"
}

public enum StatusLabel: String, Codable {
    case mClose = "M_CLOSE"
    case mFullTime = "M_FULL_TIME"
    case mOpen = "M_OPEN"
}


public struct ProductCategory: Codable {
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
public struct Product: Codable {
    public let alias: String
    public let menu, new, id: Int
    public let label, imageTitle, content: String
    public let itemNumber, inventory, restID, instock: Int
    public let desiredStock: Int
    public let price: String
    public let restaurantMenuCategories: Int
    public let image, type, keywords, readyTime: String
    public let options: [Option]?
    public let src: String
    
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
public struct Option: Codable {
    public let id, minimum, maximum: Int
    public var active: Int
    public let free, freemax, restaurantProducts, restaurant: Int
    public let position: Int
    public let optionTitle: String
    public let lngID: Int
    public let label: String
    public let choices: [Choice]
    
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
public struct Choice: Codable {
    public let id, active, restaurantOptions: Int
    public let price: String
    public let position, nest, restaurant: Int
    public let choiceOtherName: String
    public let lngID: Int
    public let label: String
    
    enum CodingKeys: String, CodingKey {
        case id, active
        case restaurantOptions = "restaurant_options"
        case price, position, nest, restaurant
        case choiceOtherName = "choice_other_name"
        case lngID = "lng_id"
        case label
    }
}

