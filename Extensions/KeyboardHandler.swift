//
//  Created by Vladimir on 2/5/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

public typealias KeyboardFrame = CGRect

public extension NotificationDescriptor {
    
    static var keyboardWillShowDescriptor: NotificationDescriptor<KeyboardFrame> {
        return NotificationDescriptor<KeyboardFrame>(name: UIResponder.keyboardWillShowNotification) { (notification) -> KeyboardFrame in
            return notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? KeyboardFrame ?? .zero
            
        }
    }
    
    static var keyboardWillHideDescriptor: NotificationDescriptor<KeyboardFrame> {
        return NotificationDescriptor<KeyboardFrame>(name: UIResponder.keyboardWillHideNotification) { (notification) -> KeyboardFrame in
            return notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? KeyboardFrame ?? .zero
            
        }
    }
    
}
