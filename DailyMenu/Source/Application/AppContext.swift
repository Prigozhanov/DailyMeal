//
//  Created by Vladimir on 1/13/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import Services

typealias AppContextProtocol =
    CartServiceHolder &
    NetworkServiceHolder &
    KeychainServiceHolder &
    UserDefaultsServiceHolder

class AppContext: AppContextProtocol {
    
    var networkService: NetworkService
    var cartService: CartService
    var keychainSevice: KeychainService
    var userDefaultsService: UserDefaultsService
    
    init() {
        self.cartService = CartServiceImplementation()
        self.keychainSevice = KeychainServiceImplementation(identifier: Bundle.id)
        self.networkService = NetworkServiceImplementation(keychainService: keychainSevice)
        self.userDefaultsService = UserDefaultsServiceImplementation(keychainService: keychainSevice)
    }
    
}
