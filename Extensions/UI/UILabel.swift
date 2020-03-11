//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

extension UILabel {
    
    static func makeText(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = FontFamily.smallMedium
        label.textColor = Colors.charcoal.color
        return label
    }
    
    static func makeExtraSmallText(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = FontFamily.extraSmallRegular
        label.textColor = Colors.charcoal.color
        return label
    }
    
    static func makeSmallText(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
		label.font = FontFamily.smallRegular
        label.textColor = Colors.charcoal.color
        return label
    }
    
    static func makeMediumText(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = FontFamily.book
        label.textColor = Colors.charcoal.color
        return label
        
    }
    
    static func makeLargeText(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = FontFamily.largeRegular
        label.textColor = Colors.charcoal.color
        return label
    }
    
    static func makeNavigationTitle(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = FontFamily.black
        label.textColor = Colors.charcoal.color
        return label
    }
    
    static func makeSmallTitle(_ text: String? = nil) -> UILabel {
        let label = UILabel.makeText(text)
        label.font = FontFamily.Avenir.light.font(size: 10)
        return label
    }
    
	static func makeSemiboldTitle(_ text: String? = nil) -> UILabel {
		let label = UILabel.makeText(text)
		label.font = FontFamily.black
		return label
	}
	
}
