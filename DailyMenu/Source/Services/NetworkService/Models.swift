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
        if let key = values?.allKeys.first {
            data = try? values?.decode(Response.self, forKey: key)
        }
    }
    
}

// MARK: Menu

public struct MenuResponse: Codable {
    let restaurants: [Restaurant]?
}

// MARK: - Restaurant
public struct Restaurant : Codable {
    
    public struct Alt_work_hours : Codable {
        public let start : [String]?
        public let close : [String]?
        public let minutes : Int?
        
        enum CodingKeys: String, CodingKey {
            
            case start = "start"
            case close = "close"
            case minutes = "minutes"
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            start = try values.decodeIfPresent([String].self, forKey: .start)
            close = try values.decodeIfPresent([String].self, forKey: .close)
            minutes = try values.decodeIfPresent(Int.self, forKey: .minutes)
        }
        
    }
    
    
    public let id : Int?
    public let alias : String?
    public let image : String?
    public let additional_image_api : String?
    public let rate : String?
    public let budget : String?
    public let new : Int?
    public let min_amount_order : Int?
    public let hash : String?
    public let position : Int?
    public let restaurant_chain : String?
    public let primary_in_chain : Int?
    public let has_takeaway : String?
    public let restaurant_takeaway_time : Int?
    public let restaurantPrepTime : Int?
    public let area : Int?
    public let map_marker : String?
    public let chain_count : Int?
    public let latitude : Double?
    public let longitude : Double?
    public let rest_delivery_fee : String?
    public let mil_1 : Int?
    public let mil_2 : Int?
    public let mil_3 : Int?
    public let mil_4 : Int?
    public let price_1 : String?
    public let price_2 : String?
    public let price_3 : String?
    public let price_4 : String?
    public let sponsored : String?
    public let sponsored_restaurant_types_flat : String?
    public let use_poligon : String?
    public let label : String?
    public let description : String?
    public let action_text : String?
    public let chain_id : Int?
    public let chain_label : String?
    public let totalHours : Int?
    public let openTime : String?
    public let closeTime : String?
    public let around : Int?
    public let alt_work_hours : [Alt_work_hours]?
    public let status : String?
    public let status_label : String?
    public let src : String?
    public let additional_image_api_src : String?
    //    public let sponsored_restaurant_types : [String:String]?
    public let type : String?
    public let distance : Double?
    public let source : String?
    public let duration : Double?
    public let distanceMetr : Double?
    public let sortByMinutes : Double?
    public let orderDelayFirst : Int?
    public let orderDelaySecond : Int?
    public let poligon_match : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case alias = "alias"
        case image = "image"
        case additional_image_api = "additional_image_api"
        case rate = "rate"
        case budget = "budget"
        case new = "new"
        case min_amount_order = "min_amount_order"
        case hash = "hash"
        case position = "position"
        case restaurant_chain = "restaurant_chain"
        case primary_in_chain = "primary_in_chain"
        case has_takeaway = "has_takeaway"
        case restaurant_takeaway_time = "restaurant_takeaway_time"
        case restaurantPrepTime = "RestaurantPrepTime"
        case area = "area"
        case map_marker = "map_marker"
        case chain_count = "chain_count"
        case latitude = "latitude"
        case longitude = "longitude"
        case rest_delivery_fee = "rest_delivery_fee"
        case mil_1 = "mil_1"
        case mil_2 = "mil_2"
        case mil_3 = "mil_3"
        case mil_4 = "mil_4"
        case price_1 = "price_1"
        case price_2 = "price_2"
        case price_3 = "price_3"
        case price_4 = "price_4"
        case sponsored = "sponsored"
        case sponsored_restaurant_types_flat = "sponsored_restaurant_types_flat"
        case use_poligon = "use_poligon"
        case label = "label"
        case description = "description"
        case action_text = "action_text"
        case chain_id = "chain_id"
        case chain_label = "chain_label"
        case totalHours = "totalHours"
        case openTime = "openTime"
        case closeTime = "closeTime"
        case around = "around"
        case alt_work_hours = "alt_work_hours"
        case status = "status"
        case status_label = "status_label"
        case src = "src"
        case additional_image_api_src = "additional_image_api_src"
        //        case sponsored_restaurant_types = "sponsored_restaurant_types"
        case type = "type"
        case distance = "distance"
        case source = "source"
        case duration = "duration"
        case distanceMetr = "distanceMetr"
        case sortByMinutes = "sortByMinutes"
        case orderDelayFirst = "orderDelayFirst"
        case orderDelaySecond = "orderDelaySecond"
        case poligon_match = "poligon_match"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        alias = try values.decodeIfPresent(String.self, forKey: .alias)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        additional_image_api = try values.decodeIfPresent(String.self, forKey: .additional_image_api)
        rate = try values.decodeIfPresent(String.self, forKey: .rate)
        budget = try values.decodeIfPresent(String.self, forKey: .budget)
        new = try values.decodeIfPresent(Int.self, forKey: .new)
        min_amount_order = try values.decodeIfPresent(Int.self, forKey: .min_amount_order)
        hash = try values.decodeIfPresent(String.self, forKey: .hash)
        position = try values.decodeIfPresent(Int.self, forKey: .position)
        restaurant_chain = try values.decodeIfPresent(String.self, forKey: .restaurant_chain)
        primary_in_chain = try values.decodeIfPresent(Int.self, forKey: .primary_in_chain)
        has_takeaway = try values.decodeIfPresent(String.self, forKey: .has_takeaway)
        restaurant_takeaway_time = try values.decodeIfPresent(Int.self, forKey: .restaurant_takeaway_time)
        restaurantPrepTime = try values.decodeIfPresent(Int.self, forKey: .restaurantPrepTime)
        area = try values.decodeIfPresent(Int.self, forKey: .area)
        map_marker = try values.decodeIfPresent(String.self, forKey: .map_marker)
        chain_count = try values.decodeIfPresent(Int.self, forKey: .chain_count)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        rest_delivery_fee = try values.decodeIfPresent(String.self, forKey: .rest_delivery_fee)
        mil_1 = try values.decodeIfPresent(Int.self, forKey: .mil_1)
        mil_2 = try values.decodeIfPresent(Int.self, forKey: .mil_2)
        mil_3 = try values.decodeIfPresent(Int.self, forKey: .mil_3)
        mil_4 = try values.decodeIfPresent(Int.self, forKey: .mil_4)
        price_1 = try values.decodeIfPresent(String.self, forKey: .price_1)
        price_2 = try values.decodeIfPresent(String.self, forKey: .price_2)
        price_3 = try values.decodeIfPresent(String.self, forKey: .price_3)
        price_4 = try values.decodeIfPresent(String.self, forKey: .price_4)
        sponsored = try values.decodeIfPresent(String.self, forKey: .sponsored)
        sponsored_restaurant_types_flat = try values.decodeIfPresent(String.self, forKey: .sponsored_restaurant_types_flat)
        use_poligon = try values.decodeIfPresent(String.self, forKey: .use_poligon)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        action_text = try values.decodeIfPresent(String.self, forKey: .action_text)
        chain_id = try values.decodeIfPresent(Int.self, forKey: .chain_id)
        chain_label = try values.decodeIfPresent(String.self, forKey: .chain_label)
        totalHours = try values.decodeIfPresent(Int.self, forKey: .totalHours)
        openTime = try values.decodeIfPresent(String.self, forKey: .openTime)
        closeTime = try values.decodeIfPresent(String.self, forKey: .closeTime)
        around = try values.decodeIfPresent(Int.self, forKey: .around)
        alt_work_hours = try values.decodeIfPresent([Alt_work_hours].self, forKey: .alt_work_hours)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        status_label = try values.decodeIfPresent(String.self, forKey: .status_label)
        src = try values.decodeIfPresent(String.self, forKey: .src)
        additional_image_api_src = try values.decodeIfPresent(String.self, forKey: .additional_image_api_src)
        //        sponsored_restaurant_types = try values.decodeIfPresent(Sponsored_restaurant_types.self, forKey: .sponsored_restaurant_types)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        duration = try values.decodeIfPresent(Double.self, forKey: .duration)
        distanceMetr = try values.decodeIfPresent(Double.self, forKey: .distanceMetr)
        sortByMinutes = try values.decodeIfPresent(Double.self, forKey: .sortByMinutes)
        orderDelayFirst = try values.decodeIfPresent(Int.self, forKey: .orderDelayFirst)
        orderDelaySecond = try values.decodeIfPresent(Int.self, forKey: .orderDelaySecond)
        poligon_match = try values.decodeIfPresent(Bool.self, forKey: .poligon_match)
    }
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
public struct Product: Codable {
    public let alias: String?
    public let menu, new, id: Int?
    public let label, imageTitle, content: String?
    public let itemNumber, inventory, restID, instock: Int?
    public let desiredStock: Int?
    public let price: String?
    public let restaurantMenuCategories: Int?
    public let image: String?
    public let type: String?
    public let keywords, readyTime: String?
    public let src: String?
    
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
        case src
    }
}


