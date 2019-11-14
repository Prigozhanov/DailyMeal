//
// Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit


extension UILabel {
    
    static func makeExtraSmallText(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = FontFamily.extraSmallRegular
        return label
    }
    
    static func makeSmallText(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = FontFamily.smallRegular
        return label
    }
    
    static func makeMediumText(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = FontFamily.regular
        return label
        
    }
    
    static func makeLargeText(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = FontFamily.largeRegular
        return label
    }
    
}
