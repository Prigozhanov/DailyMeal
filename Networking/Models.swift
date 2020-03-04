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
// TODO: some fields are missing in this structure, see menu.by response to add them then
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
    public let model: User?
    public let success: Bool?
    public let message, jwtToken: String?
    public let token: String?
    public let responseCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case member, model, success, message
        case jwtToken = "JWTToken"
        case token, responseCode
    }
}

// MARK: - PushRegistration
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
    case restaurant, shop
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
    case close, open
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
    public let src: String?
    public let imageTitle, image: String?
    public let inventory, new: Int?
    public var options: [Option]?
    public let restWorkingTime: [RESTWorkingTime]?
    public let restID: Int?
    public let keywords, alias: String?
    public let menu, instock: Int?
    public let type, restDeliveryFee, chainLabel: String?
    public let id: Int
    public let label: String
    public var productcount: Int?
    public let itemNumber, restaurantMenuCategories: Int?
    public let readyTime: String?
    public let price: String
    public let comment: String?
    public let desiredStock: Int?
    public let content: String?
    
    public var overallPrice: Double {
        let productPrice = Double(price) ?? 0
        let optionsPrice = options?.flatMap({ $0.choices }).reduce(0.0, { (res, choice) -> Double in
            res + (Double(choice.price) ?? 0)
        }) ?? 0
        return productPrice + optionsPrice
    }
    
    enum CodingKeys: String, CodingKey {
        case src
        case imageTitle = "image_title"
        case image, inventory, new, options, restWorkingTime
        case restID = "rest_id"
        case keywords, alias, menu, instock, type
        case restDeliveryFee = "rest_delivery_fee"
        case chainLabel = "chain_label"
        case id, label, productcount
        case itemNumber = "item_number"
        case restaurantMenuCategories = "restaurant_menu_categories"
        case readyTime = "ready_time"
        case price, comment
        case desiredStock = "desired_stock"
        case content
    }
    
    public mutating func addChoiceForOption(_ choice: Choice, optionId: Int) {
        let localOptions = options
        localOptions?.enumerated().forEach({ index, item in
            if item.id == optionId {
                self.options?[index].addChoice(choice)
            }
        })
    }
    
    public mutating func removeChoiceForOption(_ choice: Choice, optionId: Int) {
        let localOptions = options
        localOptions?.enumerated().forEach({ index, item in
            if item.id == optionId {
                self.options?[index].removeChoice(choice)
            }
        })
    }
    
    public mutating func removeAllChoices() {
        let localOptions = options
        localOptions?.enumerated().forEach({ index, _ in
            self.options?[index].choices = []
        })
    }
}

// MARK: - RESTWorkingTime
public struct RESTWorkingTime: Codable {
    public let close: [String]?
    public let minutes: Int?
    public let start: [String]?
    
    public init(close: [String]?, minutes: Int?, start: [String]?) {
        self.close = close
        self.minutes = minutes
        self.start = start
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
    public var choices: [Choice]
    
    enum CodingKeys: String, CodingKey {
        case id, active, minimum, maximum, free, freemax
        case restaurantProducts = "restaurant_products"
        case restaurant, position
        case optionTitle = "option_title"
        case lngID = "lng_id"
        case label, choices
    }
    
    public mutating func addChoice(_ choice: Choice) {
        choices.append(choice)
    }
    
    public mutating func removeChoice(_ choice: Choice) {
        choices.removeAll(where: { $0.id == choice.id })
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

// MARK: - GeodataIsExists
// Menu.by checks is current address exist and returns consistent app data
public struct GeodataIsExists: Codable {
    public let geoobjects: [GeoObject]?
    public let id: Int?
    public let isAddressExists: IsAddressExists?
    
    public init(geoobjects: [GeoObject]?, id: Int?, isAddressExists: IsAddressExists?) {
        self.geoobjects = geoobjects
        self.id = id
        self.isAddressExists = isAddressExists
    }
    
    func encoded() throws -> [String: Any]? {
        let jsonData = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        return json
    }
}

// MARK: - IsAddressExists
public struct IsAddressExists: Codable {
    public let id, addressesID: Int?
    public let long, lat: String?
    public let area, areaID, regionID, streetID: Int?
    public let streetLabel3, streetLabel6, streetLabel7, building3: String?
    public let building6, building7, lng3, lng6: String?
    public let lng7, hash: String?
    public let position: Int?
    public let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case addressesID = "addresses_id"
        case long, lat, area, areaID, regionID, streetID
        case streetLabel3 = "street_label_3"
        case streetLabel6 = "street_label_6"
        case streetLabel7 = "street_label_7"
        case building3 = "building_3"
        case building6 = "building_6"
        case building7 = "building_7"
        case lng3 = "lng_3"
        case lng6 = "lng_6"
        case lng7 = "lng_7"
        case hash, position
        case updatedAt = "updated_at"
    }
}

// MARK: - ShoppingCartRequest
public struct ShoppingCartRequest: Codable {
    public let paymentMethods: Int
    public let yourNotes: String
    public let memberID: Int
    public let intercom: String
    public let phoneConfirm: Int
    public let timeMinute, fullname: String
    public let addressID: Int
    public let deliveryDate: Double
    public let details, apartament, house, orderType: String
    public let floor: String
    public let recuringUserID, restID, deliveryDirtyLong: Int
    public let coupon, deliveryType, deliveryAddress: String
    public let deliveryDirtyLat: Int
    public let delivery, timeHour, addressDetails, entrance: String
    public let phone: String
    public let products: [Product]
    public let usebonus: String
    
    enum CodingKeys: String, CodingKey {
        case paymentMethods = "payment_methods"
        case yourNotes = "your_notes"
        case memberID = "member_id"
        case intercom
        case phoneConfirm = "phone_confirm"
        case timeMinute = "Time_Minute"
        case fullname
        case addressID = "addressId"
        case deliveryDate = "delivery_date"
        case details, apartament, house
        case orderType = "order_type"
        case floor
        case recuringUserID = "recuring-user-id"
        case restID = "rest_id"
        case deliveryDirtyLong = "delivery_dirty_long"
        case coupon
        case deliveryType = "delivery_type"
        case deliveryAddress = "delivery_address"
        case deliveryDirtyLat = "delivery_dirty_lat"
        case delivery
        case timeHour = "Time_Hour"
        case addressDetails = "address_details"
        case entrance, phone, products, usebonus
    }
    
    public init(paymentMethods: Int,
                yourNotes: String,
                memberID: Int,
                intercom: String,
                phoneConfirm: Int,
                timeMinute: String,
                fullname: String,
                addressID: Int,
                deliveryDate: Double,
                details: String,
                apartament: String,
                house: String,
                orderType: String,
                floor: String,
                recuringUserID: Int,
                restID: Int,
                deliveryDirtyLong: Int,
                coupon: String,
                deliveryType: String,
                deliveryAddress: String,
                deliveryDirtyLat: Int,
                delivery: String,
                timeHour: String,
                addressDetails: String,
                entrance: String,
                phone: String,
                products: [Product],
                usebonus: String) {
        self.paymentMethods = paymentMethods
        self.yourNotes = yourNotes
        self.memberID = memberID
        self.intercom = intercom
        self.phoneConfirm = phoneConfirm
        self.timeMinute = timeMinute
        self.fullname = fullname
        self.addressID = addressID
        self.deliveryDate = deliveryDate
        self.details = details
        self.apartament = apartament
        self.house = house
        self.orderType = orderType
        self.floor = floor
        self.recuringUserID = recuringUserID
        self.restID = restID
        self.deliveryDirtyLong = deliveryDirtyLong
        self.coupon = coupon
        self.deliveryType = deliveryType
        self.deliveryAddress = deliveryAddress
        self.deliveryDirtyLat = deliveryDirtyLat
        self.delivery = delivery
        self.timeHour = timeHour
        self.addressDetails = addressDetails
        self.entrance = entrance
        self.phone = phone
        self.products = products
        self.usebonus = usebonus
    }
    
    func encoded() -> [String: Any] {
        let jsonData = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        return json
    }
}

// MARK: - ShoppingCartResponse
public struct ShoppingCartResponse: Codable {
    public let success: Bool
    public let rawRequest: ShoppingCartRequest
    public let rawResponse: ShoppingCartRawResponse
    
    enum CodingKeys: String, CodingKey {
        case success
        case rawRequest = "raw_request"
        case rawResponse = "raw_response"
    }
    
    public init(success: Bool, rawRequest: ShoppingCartRequest, rawResponse: ShoppingCartRawResponse) {
        self.success = success
        self.rawRequest = rawRequest
        self.rawResponse = rawResponse
    }
}

// MARK: - ShoppingCartRawResponse
public struct ShoppingCartRawResponse: Codable {
    public let basketData: BasketData?
    public let post: Post?
    public let orderID, rate: String?
    
    enum CodingKeys: String, CodingKey {
        case basketData = "basket_data"
        case post
        case orderID = "order_id"
        case rate
    }
    
    public init(basketData: BasketData?, post: Post?, orderID: String?, rate: String?) {
        self.basketData = basketData
        self.post = post
        self.orderID = orderID
        self.rate = rate
    }
}

// MARK: - BasketData
public struct BasketData: Codable {
    public let price, totalPrice: Double?
    public let currentLngID, deliveryPrice, paymentMethod: Int?
    public let orderType: String?
    public let useBonus, usedBonus, pushID: Int?
    public let deliveryType: String?
    public let addressID, changeLat, changeLong: Int?
    
    enum CodingKeys: String, CodingKey {
        case price
        case totalPrice = "total_price"
        case currentLngID = "currentLngId"
        case deliveryPrice = "delivery_price"
        case paymentMethod = "payment_method"
        case orderType = "order_type"
        case useBonus = "use_bonus"
        case usedBonus = "used_bonus"
        case pushID = "push_id"
        case deliveryType = "delivery_type"
        case addressID = "addressId"
        case changeLat = "change_lat"
        case changeLong = "change_long"
    }
    
    public init(price: Double?, totalPrice: Double?, currentLngID: Int?, deliveryPrice: Int?, paymentMethod: Int?, orderType: String?, useBonus: Int?, usedBonus: Int?, pushID: Int?, deliveryType: String?, addressID: Int?, changeLat: Int?, changeLong: Int?) {
        self.price = price
        self.totalPrice = totalPrice
        self.currentLngID = currentLngID
        self.deliveryPrice = deliveryPrice
        self.paymentMethod = paymentMethod
        self.orderType = orderType
        self.useBonus = useBonus
        self.usedBonus = usedBonus
        self.pushID = pushID
        self.deliveryType = deliveryType
        self.addressID = addressID
        self.changeLat = changeLat
        self.changeLong = changeLong
    }
}

// MARK: - Post
public struct Post: Codable {
    public let quickOrderPhone, address: String?
    public let addresInfo: AddresInfo?
    public let userInfo: UserInfo?
    public let paymentMethod: Int?
    
    enum CodingKeys: String, CodingKey {
        case quickOrderPhone = "quick_order_phone"
        case address
        case addresInfo = "addres_info"
        case userInfo = "user_info"
        case paymentMethod = "payment_method"
    }
    
    public init(quickOrderPhone: String?, address: String?, addresInfo: AddresInfo?, userInfo: UserInfo?, paymentMethod: Int?) {
        self.quickOrderPhone = quickOrderPhone
        self.address = address
        self.addresInfo = addresInfo
        self.userInfo = userInfo
        self.paymentMethod = paymentMethod
    }
}

// MARK: - AddresInfo
public struct AddresInfo: Codable {
    public let city, street, apartament, house: String?
    public let entrance, floor, intercom, coupon: String?
    public let addressDetails: String?
    
    enum CodingKeys: String, CodingKey {
        case city, street, apartament, house, entrance, floor, intercom, coupon
        case addressDetails = "address_details"
    }
    
    public init(city: String?, street: String?, apartament: String?, house: String?, entrance: String?, floor: String?, intercom: String?, coupon: String?, addressDetails: String?) {
        self.city = city
        self.street = street
        self.apartament = apartament
        self.house = house
        self.entrance = entrance
        self.floor = floor
        self.intercom = intercom
        self.coupon = coupon
        self.addressDetails = addressDetails
    }
}

// MARK: - UserInfo
public struct UserInfo: Codable {
    public let details: String?
    
    public init(details: String?) {
        self.details = details
    }
}

public enum Language: String {
	case ru = "6", en = "7"
}
