//
//  Created by Vladimir on 1/14/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

class Formatter {
    
    struct Currency {
        static func toString(_ value: Double?) -> String {
            guard let value = value else {
                return "Error"
            }
            return value < 0 ? String(format: "- $%.2f", abs(value)) : String(format: "$%.2f", value)
        }
    }
    
}
