//
//  Design.swift
//  DailyMenu
//
//  Created by Vladimir on 10/11/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class Design {
    class Layout {
        static let commonMargin = 7
        static let largeMargin = 15
    }
    
    class Label {
        static func smallText(_ text: String) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 15)
            return label
        }
        
        static func mediumText(_ text: String) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 17)
            return label
        }
        
        static func largeText(_ text: String) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 19)
            return label
        }
    }
    
    class Button {
        static func commonButton(_ text: String, action: @escaping () -> Void) -> UIButton {
            let button = UIButton()
            button.setTitle(text, for: .normal)
            button.setTitleColor(.d_commonBlue, for: .normal)
            button.actionHandler(controlEvents: .touchUpInside, ForAction: action)
            return button
        }
        
        static func grayButton(_ text: String, action: @escaping () -> Void) -> UIButton {
            let button = UIButton()
            button.setAttributedTitle(NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]), for: .normal)
            button.actionHandler(controlEvents: .touchUpInside, ForAction: action)
            return button
        }
    }
    
}
