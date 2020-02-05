//
//  Created by Vladimir on 2/4/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public protocol UserDefaultsServiceHolder {
    
    var userDefaultsService: UserDefaultsService { get }
    
}

public protocol UserDefaultsService {
    
    func setValueForKey(key: UserDefaultsKey, value: Any)
    
    func getValueForKey(key: UserDefaultsKey) -> Any?
    
    func removeAllValues()
    
}

public class UserDefaultsServiceImplementation: UserDefaultsService {
    
    private let userDefaults: UserDefaults
    
    private let keychainService: KeychainService
    
    public init(keychainService: KeychainService) {
        self.keychainService = keychainService
        userDefaults = UserDefaults.standard
    }
    
    public func setValueForKey(key: UserDefaultsKey, value: Any) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    public func getValueForKey(key: UserDefaultsKey) -> Any? {
        userDefaults.value(forKey: key.rawValue)
    }
    
    public func removeAllValues() {
        UserDefaultsKey.allCases.forEach { userDefaults.removeObject(forKey: $0.rawValue) }
    }
}

public enum UserDefaultsKey: String, CaseIterable {
    case id,
    name,
    lastname,
    email,
    phone
}
