//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public struct Request<Response: Codable> {
    
    public enum Method: String {
        case GET, POST
    }
    
    public enum Params {
        case none
        case query([String : String])
    }
    
    let method: Method
    let baseUrlString: String
    let path: String
    let params: Params
    
}

public class Requests {
    private static let baseUrlString = "https://v2.menu.by/api/"
    
    static func menu() -> Request<MenuResponse> {
        return Request<MenuResponse>(method: .GET,
                                     baseUrlString: baseUrlString,
                                     path: "get-RestDataByType",
                                     params: .query([
                                        "type": "all",
                                        "lng": "7",
                                        "delivery_type": "delivery",
                                        "city_id": "2",
                                        "localization": "1",
                                        "addressId": "39307",
                                     ]))
    }
    
    static func restaurantCategories(id: String) -> Request<Category> {
        //https://v2.menu.by/api/get-restaurant-menu-categories?rest=84&lng=7
        return Request<Category>(method: .GET,
                                 baseUrlString: baseUrlString,
                                 path: "get-restaurant-menu-categories",
                                 params: .query(["rest" : id, "lng": "7"]))
    }
    
    static func restaurantMenu(id: Int) -> Request<ResponseWrapper<[Product]>> {
        //https://v2.menu.by/api/get-restaurant-menu?rest=1595&lng=7&restaurant_menu_categories=4729
        return Request<ResponseWrapper<[Product]>>(method: .GET,
                                  baseUrlString: baseUrlString,
                                  path: "get-restaurant-menu",
                                  params: .query([
                                    "rest" : "\(id)",
                                    "lng": "7" // TODO link with category id
                                  ]))
    }
    
}
