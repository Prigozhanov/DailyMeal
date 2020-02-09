//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import MapKit

public struct Request<Response: Codable> {
    
    public init(method: Request<Response>.Method, baseUrlString: String, path: String, params: Request<Response>.Params) {
        self.method = method
        self.baseUrlString = baseUrlString
        self.path = path
        self.params = params
    }
    
    
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

public class RequestFactory {
    private let baseUrlString = "https://v2.menu.by/api/"
    private let secondaryUrlString = "https://apiv2.menu.by/"
    
    public init() {}
    
    //https://apiv2.menu.by/index/authenticate
    public func authenticate(userName: String, password: String) -> Request<LoginResponse> {
        return Request<LoginResponse>(method: .POST,
                                      baseUrlString: secondaryUrlString,
                                      path: "index/authenticate",
                                      params: .json(["user": userName, "pwd" : password]))
    }
    
    //https://v2.menu.by/api/user/me
    public func user() -> Request<User> {
        return Request<User>(method: .GET,
                             baseUrlString: baseUrlString,
                             path: "user/me",
                             params: .none)
    }
    
    //https://v2.menu.by/api/sms-verification/generate-token
    public func generateToken(phone: String) -> Request<ResponseWrapper<Empty>> {
        return Request<ResponseWrapper<Empty>>(method: .POST,
                                               baseUrlString: baseUrlString,
                                               path: "sms-verification/generate-token",
                                               params: .json(["phone" : phone]))
    }
    
    //https://v2.menu.by/api/sms-verification/verify-token
    public func verifyToken(validationCode: String) -> Request<LoginResponse> {
        return Request<LoginResponse>(method: .POST,
                                      baseUrlString: baseUrlString,
                                      path: "sms-verification/verify-token",
                                      params: .json(["verify_code" : validationCode]))
    }
    
    //https://v2.menu.by/api/push-registration
    public func pushRegistration() -> Request<ResponseWrapper<PushRegistration>> {
        return Request<ResponseWrapper<PushRegistration>>(method: .POST,
                                                          baseUrlString: baseUrlString,
                                                          path: "api/push-registration",
                                                          params: .none)
    }
    
    public func menu() -> Request<MenuResponse> {
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
    public func restaurantCategories(id: Int) -> Request<SingleKeyResponseWrapper<[ProductCategory]>> {
        return Request<SingleKeyResponseWrapper<[ProductCategory]>>(method: .GET,
                                                                    baseUrlString: baseUrlString,
                                                                    path: "get-restaurant-menu-categories",
                                                                    params: .query(["rest" : "\(id)", "lng": "6"]))
    }
    
    //https://v2.menu.by/api/get-restaurant-menu?rest=1595&lng=7&restaurant_menu_categories=4729
    public func restaurantMenu(id: Int) -> Request<SingleKeyResponseWrapper<[Product]>> {
        return Request<SingleKeyResponseWrapper<[Product]>>(method: .GET,
                                                            baseUrlString: baseUrlString,
                                                            path: "get-restaurant-menu",
                                                            params: .query([
                                                                "rest" : "\(id)",
                                                                "lng": "6" // TODO link with category id
                                                            ]))
    }
    
    public func geodataIsExists(geodataRequest: MenuV2GeodataRequest) -> Request<GeodataIsExists> {
        return Request<GeodataIsExists>(method: .POST,
                                        baseUrlString: baseUrlString,
                                        path: "address/set-addresses",
                                        params: .json(geodataRequest.encoded()))
    }
    
    ///----------------------///
    ///---YANDEX GEOCODER ---///
    ///----------------------///
    private let yandexGeodecoderUrlString = "https://geocode-maps.yandex.ru/"
    private let yandexGeocoderApiKey = "3832850a-49ca-413e-87fa-d5426a875301"
    
    public func getGeocode(lat: Double, lon: Double) -> Request<Geodata?> {
        return Request<Geodata?>(method: .GET,
                                baseUrlString: yandexGeodecoderUrlString,
                                path: "1.x/",
                                params: .query([
                                    "apikey": yandexGeocoderApiKey,
                                    "format": "json",
                                    "geocode": "\(lon),\(lat)",
                                    "lang": "en",
                                    "result": "1"
                                ]))
    }
    
    //https://geocode-maps.yandex.ru/1.x/?apikey=3832850a-49ca-413e-87fa-d5426a875301&geocode=%string%
    public func getGeodataByString(string: String) -> Request<Geodata?> {
        return Request<Geodata?>(method: .GET,
                                 baseUrlString: yandexGeodecoderUrlString,
                                 path: "1.x/",
                                 params: .query([
                                    "apikey": yandexGeocoderApiKey,
                                    "format": "json",
                                    "geocode": string,
                                    "lang": "en",
                                    "result": "10"
                                 ]))
    }
    
}
