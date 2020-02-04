//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public extension Optional where Wrapped == String {
    
    var orEmpty: String {
        switch self {
        case let .some(value):
            return value
        case .none:
            return ""
        }
    }
    
}
