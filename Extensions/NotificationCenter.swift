//
//  Created by Vladimir on 2/5/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

extension NotificationCenter {
    
    func addObserver<T>(descriptor: NotificationDescriptor<T>, queue: DispatchQueue = DispatchQueue.main, using: @escaping (T) -> Void) -> Token {
        let token = addObserver(forName: descriptor.name, object: nil, queue: nil) { notification in
            using(descriptor.convert(notification))
        }
        
        return Token(token: token, center: self)
    }
    
}

public struct NotificationDescriptor<T> {
    
    let name: Notification.Name
    let convert: (Notification) -> T
    
    public init(name: Notification.Name, convert: @escaping (Notification) -> T) {
        self.name = name
        self.convert = convert
    }
    
}

public class Token {
    
    let token: NSObjectProtocol
    let center: NotificationCenter
    
    public init(token: NSObjectProtocol, center: NotificationCenter) {
        self.token = token
        self.center = center
    }
    
    deinit {
        center.removeObserver(token)
    }
    
    public class func make<T>(descriptor: NotificationDescriptor<T>, center: NotificationCenter = NotificationCenter.default, using: @escaping (T) -> Void) -> Token {
       return center.addObserver(descriptor: descriptor, using: using)
    }
    
}

public extension Notification.Name {
    
    static var userSignedUp = Notification.Name("userSignedUp")
    static var userLoggedIn = Notification.Name("userLoggedIn")
    static var userLoggedOut = Notification.Name("userLoggedOut")
    static var userInvalidAddress = Notification.Name("userInvalidAddress")
    static var userAddressChanged = Notification.Name("userAddressChanged")
    
}
