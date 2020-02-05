//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public struct Request<Response: Codable> {
    
    public enum Method: String {
        case GET, POST
        var hasBody: Bool {
            return self == .POST
        }
    }
    
    public enum Params {
        case none
        case query([String : String])
        case json([String: Any])
    }
    
    public let method: Method
    public let baseUrlString: String
    public let path: String
    public let params: Params
    
}

public class Requests {
    private static let baseUrlString = "https://v2.menu.by/api/"
    private static let secondaryUrlString = "https://apiv2.menu.by/"
    
    //https://apiv2.menu.by/index/authenticate
    public static func authenticate(userName: String, password: String) -> Request<LoginResponse> {
        return Request<LoginResponse>(method: .POST,
                             baseUrlString: secondaryUrlString,
                             path: "index/authenticate",
                             params: .json(["user": userName, "pwd" : password]))
    }
    
    //https://v2.menu.by/api/user/me
    public static func user() -> Request<User> {
        return Request<User>(method: .GET,
                             baseUrlString: baseUrlString,
                             path: "user/me",
                             params: .none)
    }
    
    //https://v2.menu.by/api/sms-verification/generate-token
    public static func generateToken(phone: String) -> Request<ResponseWrapper<Empty>> {
        return Request<ResponseWrapper<Empty>>(method: .POST,
                                        baseUrlString: baseUrlString,
                                        path: "sms-verification/generate-token",
                                        params: .json(["phone" : phone]))
    }
    
    //https://v2.menu.by/api/sms-verification/verify-token
    public static func verifyToken(verifyCode: String) -> Request<ResponseWrapper<PushRegistration>> {
        return Request<ResponseWrapper>(method: .POST,
                                        baseUrlString: baseUrlString,
                                        path: "sms-verification/verify-token",
                                        params: .json(["verify_code" : verifyCode]))
    }
    
    //https://v2.menu.by/api/push-registration
    public static func pushRegistration() -> Request<ResponseWrapper<PushRegistration>> {
        return Request<ResponseWrapper<PushRegistration>>(method: .POST,
                                                          baseUrlString: baseUrlString,
                                                          path: "api/push-registration",
                                                          params: .json([:]))
    }
    
    public static func menu() -> Request<MenuResponse> {
        return Request<MenuResponse>(method: .GET,
                                     baseUrlString: baseUrlString,
                                     path: "get-RestDataByType",
                                     params: .query([
                                        "type": "all",
                                        "lng": "6",
                                        "delivery_type": "delivery",
                                        "city_id": "2",
                                        "localization": "1",
                                        "addressId": "39307",
                                     ]))
    }
    
    //https://v2.menu.by/api/get-restaurant-menu-categories?rest=84&lng=7
    public static func restaurantCategories(id: Int) -> Request<SingleKeyResponseWrapper<[ProductCategory]>> {
        return Request<SingleKeyResponseWrapper<[ProductCategory]>>(method: .GET,
                                 baseUrlString: baseUrlString,
                                 path: "get-restaurant-menu-categories",
                                 params: .query(["rest" : "\(id)", "lng": "6"]))
    }
    
    //https://v2.menu.by/api/get-restaurant-menu?rest=1595&lng=7&restaurant_menu_categories=4729
    public static func restaurantMenu(id: Int) -> Request<SingleKeyResponseWrapper<[Product]>> {
        return Request<SingleKeyResponseWrapper<[Product]>>(method: .GET,
                                  baseUrlString: baseUrlString,
                                  path: "get-restaurant-menu",
                                  params: .query([
                                    "rest" : "\(id)",
                                    "lng": "6" // TODO link with category id
                                  ]))
    }
    
}
