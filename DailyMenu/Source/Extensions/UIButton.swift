//
//  UIButton.swift
//  DailyMenu
//
//  Created by Vladimir on 10/11/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import UIKit

var pointer = UnsafeRawPointer(bitPattern: 0)

extension UIButton {
    func setActionHandler(controlEvents control :UIControl.Event, ForAction action: @escaping (UIButton) -> Void) {
        let actionWrapper = ActionWrapper(action)
        
        objc_setAssociatedObject(self, &pointer, actionWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        removeTarget(self, action: nil, for: .allEvents)
        addTarget(self, action: #selector(invokeAction), for: control)
    }
    
    @objc func invokeAction() {
        if let obj = objc_getAssociatedObject(self, &pointer) as? ActionWrapper {
            obj.action(self)
        }
    }
}

class ActionWrapper {
    var action: (UIButton) -> Void
    
    init(_ action: @escaping (UIButton) -> Void) {
        self.action = action
    }
}
