//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import os.log

class URLRequestBuilder<Response: Codable> {
    private let request: Request<Response>
    private let urlString: String
    
    init(request: Request<Response>) {
        self.request = request
        self.urlString = request.baseUrlString + request.path
    }
    
    var urlRequest: URLRequest {
        guard let url = URL(string: self.urlString) else {
            fatalError("\(urlString) is invalid url")
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = request.method.rawValue
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("\(urlString) is invalid url")
        }
        
        switch (request.method.hasBody, request.params) {
        case let (_, .query(values)):
            let queryItems = values.map { URLQueryItem(name: $0.key, value: $0.value) }
            components.queryItems = (components.queryItems ?? []) + queryItems
        case let (true, .json(json)):
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
                urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            } catch {
                os_log("[NETWORK] [ERROR]", error.localizedDescription)
            }
        default:
            break
        }
        
        urlRequest.url = components.url
        
        return urlRequest
    }
    
}
