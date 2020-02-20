//
//  Created by Vladimir on 2/4/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public struct Header {
    public enum HttpHeaderField: String {
        case authorization
        case contentType = "content-type"
    }
    
    public init(httpHeaderField: HttpHeaderField, value: String) {
        self.httpHeaderField = httpHeaderField
        self.value = value
    }
    
    public let httpHeaderField: HttpHeaderField
    public let value: String
}

public class URLRequestConfigurator {
    
    private var addtionalHeaders: [String: Header]
    
    public init() {
        addtionalHeaders = [:]
    }
    
    public func addHeader(_ header: Header) {
        addtionalHeaders[header.httpHeaderField.rawValue] = header
    }
    
    public func removeHeader(_ header: Header.HttpHeaderField) {
        addtionalHeaders.removeValue(forKey: header.rawValue)
    }
    
    public func configure(request: inout URLRequest) {
        addtionalHeaders.values.forEach { request.setValue($0.value, forHTTPHeaderField: $0.httpHeaderField.rawValue) }
    }
    
}
