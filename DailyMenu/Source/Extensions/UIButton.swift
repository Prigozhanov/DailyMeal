//
//  UIButton.swift
//  DailyMenu
//
//  Created by Vladimir on 10/11/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    private func actionHandler(action:(() -> Void)? = nil) {
        struct __ { static var action :(() -> Void)? }
        if action != nil { __.action = action }
        else { __.action?() }
    }
    
    @objc private func triggerActionHandler() {
        self.actionHandler()
    }
    
    func actionHandler(controlEvents control :UIControl.Event, ForAction action:@escaping () -> Void) {
        actionHandler(action: action)
        removeTarget(self, action: nil, for: .allEvents)
        addTarget(self, action: #selector(triggerActionHandler), for: control)
    }
}
