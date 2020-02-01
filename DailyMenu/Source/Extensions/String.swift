//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

extension String {
    
    func containsCaseIgnoring(_ string: String) -> Bool {
        return self.lowercased().contains(string.lowercased())
    }
    
    var withRemovedHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    
    
}
