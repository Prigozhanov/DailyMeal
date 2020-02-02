//
//  Created by Vladimir on 1/14/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

enum Formatter {
    
    enum Currency {
        static func toString(_ value: Double?) -> String {
            guard let value = value else {
                return "Error"
            }
            return value < 0 ? String(format: "- BYN %.2f", abs(value)) : String(format: "BYN %.2f", value)
        }
        
        static func fromString(_ string: String?) -> Double? {
            guard let string = string else {
                return nil
            }
            return Double(string)
        }
    }
    
    enum Distance {
        
        static func toString(_ value: Double) -> String {
            return String(format: "%.1f km", value)
        }
        
    }
    
}
