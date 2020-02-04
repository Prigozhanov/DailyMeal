//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public extension String {
    
    func containsCaseIgnoring(_ string: String) -> Bool {
        return self.lowercased().contains(string.lowercased())
    }
    
    var withRemovedHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    var onlyLetters: String {
        return filter({
            "a" ... "z" ~= $0 ||
            "A" ... "Z" ~= $0 ||
            "а" ... "я" ~= $0 ||
            "А" ... "Я" ~= $0
        })
    }
    
}
