//
//  Created by Vladimir on 2/4/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import KeychainAccess
import Extensions

public protocol KeychainServiceHolder {
    
    var keychainSevice: KeychainService { get }
    
}

public enum KeychainItem: String {
    case authToken
}


public protocol KeychainService {
    
    func setValueForItem(_ item: KeychainItem, _ value: String)
    func getValueForItem(_ item: KeychainItem) -> String?
    func removeValue(_ item: KeychainItem)
    
}

public class KeychainServiceImplementation: KeychainService {
    
    var keychain: Keychain
    
    public init() {
        keychain = Keychain(accessGroup: Bundle.id)
    }
    
    public func setValueForItem(_ item: KeychainItem, _ value: String) {
        keychain[item.rawValue] = value
    }
    
    public func getValueForItem(_ item: KeychainItem) -> String? {
        return keychain[item.rawValue]
    }
    
    public func removeValue(_ item: KeychainItem) {
        keychain[item.rawValue] = nil
    }
    
}
