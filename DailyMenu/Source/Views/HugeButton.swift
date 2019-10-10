//
//  HugeButton.swift
//  DailyMenu
//
//  Created by Vladimir on 10/10/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import SnapKit

class HugeButton: UIButton {
    required init?(coder: NSCoder) { fatalError() }
    
    init(title: String, action: @escaping () -> Void) {
        super.init(frame: .zero)
        layer.cornerRadius = 7
        snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        backgroundColor = .d_commonBlue
        setTitle(title, for: .normal)
        actionHandler(controlEvents: .touchUpInside, ForAction: action)
    }
    
    
    
    
    
}
