//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public extension String {
    
    func containsCaseIgnoring(_ string: String) -> Bool {
        return lowercased().contains(string.lowercased())
    }
    
    var withRemovedHtmlTags: String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    var onlyLetters: String {
        return filter({
            "a" ... "z" ~= $0 ||
            "A" ... "Z" ~= $0 ||
            "а" ... "я" ~= $0 ||
            "А" ... "Я" ~= $0
        })
    }
    
    var onlyNumbers: String {
        return filter({ "1" ... "9" ~= $0 })
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
}

public extension String {
	var localized: String {
		return NSLocalizedString(self, comment: "")
	}
}
