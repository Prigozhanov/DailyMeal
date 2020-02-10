//
//  Created by Vladimir on 2/4/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import Networking
import Extensions

public protocol UserDefaultsServiceHolder {
    
    var userDefaultsService: UserDefaultsService { get }
    
}

public protocol UserDefaultsService {
    
    func setValueForKey(key: UserDefaultsKey, value: Any)
    
    func getValueForKey(key: UserDefaultsKey) -> Any?
    
    func removeAllValues()
    
    func updateUserDetails(user: User)
    
    func updateUserAddressMeta(_ info: UserAddressMeta?)
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
    
    public func updateUserDetails(user: User) {
        setValueForKey(key: .id, value: user.id)
        setValueForKey(key: .name, value: user.name)
        setValueForKey(key: .lastname, value: user.lastname)
        setValueForKey(key: .email, value: user.email)
        setValueForKey(key: .phone, value: user.phone)
        setValueForKey(key: .phoneVerify, value: user.phoneVerify)
    }
    
    public func updateUserAddressMeta(_ info: UserAddressMeta?) {
        setValueForKey(key: .addressName, value: info?.addressName as Any)
        setValueForKey(key: .streetName, value: info?.streetName as Any)
        setValueForKey(key: .areaId, value: info?.areaId as Any)
        setValueForKey(key: .addressesId, value: info?.addressesId as Any)
        setValueForKey(key: .regionId, value: info?.regionId as Any)
        setValueForKey(key: .streetId, value: info?.streetId as Any)
    }
    
}

public enum UserDefaultsKey: String, CaseIterable {
    case id,
    name,
    lastname,
    email,
    phone,
    phoneVerify,
    //Address info
    addressName,
    streetName,
    areaId,
    addressesId,
    regionId,
    streetId
}

public enum PaymentMethod: Int {
    case cash = 20
}

public extension NotificationDescriptor {
    
    static var userAddressChangedDescriptor: NotificationDescriptor<Void> {
        return NotificationDescriptor<Void>(name: .userAddressChanged) { _ in }
    }
    
}
