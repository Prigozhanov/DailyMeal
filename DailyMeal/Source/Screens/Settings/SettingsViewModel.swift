//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Services

// MARK: - View
protocol SettingsView: class {
    
}

// MARK: - ViewModel
protocol SettingsViewModel {
    
    var view: SettingsView? { get set }
    
    var userName: String { get set }
    var phone: String { get set }
    var creditCardNumber: String { get }
    var address: String { get }
	
	var isUserLoggedIn: Bool { get }
	
    func clearUserInfo()
    func removeCreditCardInfo()
}

// MARK: - Implementation
final class SettingsViewModelImplementation: SettingsViewModel {
    
    weak var view: SettingsView?
    
    let context: AppContext
    let userDefaultsService: UserDefaultsService
    let keychainService: KeychainService
    
    var userName: String {
        get {
            return userDefaultsService.getValueForKey(key: .name) as? String ?? ""
        }
        set {
            userDefaultsService.setValueForKey(key: .name, value: newValue)
        }
    }
    
    var phone: String {
        get {
            return userDefaultsService.getValueForKey(key: .phone) as? String ?? ""
        }
        set {
            userDefaultsService.setValueForKey(key: .phone, value: newValue)
        }
    }
    
    var creditCardNumber: String {
            return keychainService.getValueForItem(.creditCardNumber) ?? ""
    }
    
    var address: String {
            return userDefaultsService.getValueForKey(key: .addressName) as? String ?? ""
    }
	
	var isUserLoggedIn: Bool {
		return userDefaultsService.isLoggedIn
	}
    
    init() {
        context = AppDelegate.shared.context
        userDefaultsService = context.userDefaultsService
        keychainService = context.keychainSevice
    }
    
    func clearUserInfo() {
        context.userDefaultsService.removeAllValues()
        context.keychainSevice.removeValue(.authToken)
		context.networkService.removeToken()
    }
    
    func removeCreditCardInfo() {
        context.keychainSevice.removeCardDetails()
    }
    
}
