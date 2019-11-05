//  Created by Uladzimir Pryhazhanau
//  2019


import Foundation

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
    let latitude, longitude, restDeliveryFee: String
    let mil1, mil2, mil3, mil4: Int
    let price1, price2, price3, price4: String
    let sponsored, sponsoredRestaurantTypesFlat, usePoligon: String
    let poligonmap1, poligonmap2, poligonmap3, poligonmap4: String?
    let label, restaurantDescription, chainLabel, openTime: String
    let closeTime: String
    let around: Int
    let altWorkHours: [AltWorkHour]
    let status: Status
    let statusLabel: StatusLabel
    let src: String
    let additionalImageAPISrc: String
    let type: TypeEnum
    let sponsoredRestaurantTypes: [String: String]?
    let distance: Double
    let distanceSource: DistanceSource
    let distanceMetr, sortByMinutes: Double
    let orderDelayFirst, orderDelaySecond: Int
    let menuGroupOrderDelay: String

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
        case poligonmap1 = "poligonmap_1"
        case poligonmap2 = "poligonmap_2"
        case poligonmap3 = "poligonmap_3"
        case poligonmap4 = "poligonmap_4"
        case label
        case restaurantDescription = "description"
        case chainLabel = "chain_label"
        case openTime, closeTime, around
        case altWorkHours = "alt_work_hours"
        case status
        case statusLabel = "status_label"
        case src
        case additionalImageAPISrc = "additional_image_api_src"
        case type
        case sponsoredRestaurantTypes = "sponsored_restaurant_types"
        case distance
        case distanceSource = "distance_source"
        case distanceMetr, sortByMinutes, orderDelayFirst, orderDelaySecond
        case menuGroupOrderDelay = "MenuGroupOrderDelay"
    }
}

// MARK: - AltWorkHour
struct AltWorkHour: Codable {
    let start, close: [String]
    let minutes: Int
}

enum DistanceSource: String, Codable {
    case osrm = "osrm"
}

enum Status: String, Codable {
    case close = "close"
    case statusOpen = "open"
}

enum StatusLabel: String, Codable {
    case mClose = "M_CLOSE"
    case mOpen = "M_OPEN"
}

enum TypeEnum: String, Codable {
    case restaurant = "restaurant"
    case shop = "shop"
}
