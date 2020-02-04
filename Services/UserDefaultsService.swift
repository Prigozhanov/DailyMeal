//
//  Created by Vladimir on 2/4/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public protocol UserDefaultsServiceHolder {
    
    var userDefaultsService: UserDefaultsService { get }
    
}

public protocol UserDefaultsService {
    
    func setValueForKey(key: UserDefaultsKey, value: String)
    
    func getValueForKey(key: UserDefaultsKey) -> String?
    
}

public class UserDefaultsServiceImplementation: UserDefaultsService {
    
    private let userDefaults: UserDefaults
    
    private let keychainService: KeychainService
    
    public init(keychainService: KeychainService) {
        self.keychainService = keychainService
        userDefaults = UserDefaults.standard
    }
    
    public func setValueForKey(key: UserDefaultsKey, value: String) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    public func getValueForKey(key: UserDefaultsKey) -> String? {
        userDefaults.value(forKey: key.rawValue) as? String
    }
}

public enum UserDefaultsKey: String {
    case id,
    cafullname,
    name,
    lastname,
    companyName,
    email,
    phone,
    remberMe,
    status,
    bonus,
    regDate,
    indms,
    hasRecuringCard,
    recurringCardDate,
    selectedArea,
    isTester,
    isCorporateUser,
    phoneVerify,
    emailVerify
}
