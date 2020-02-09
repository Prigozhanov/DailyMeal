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
    UserDefaultsServiceHolder &
    LocationServiceHolder

class AppContext: AppContextProtocol {
    
    var networkService: NetworkService
    var cartService: CartService
    var keychainSevice: KeychainService
    var userDefaultsService: UserDefaultsService
    var locationService: LocationService
    
    init() {
        cartService = CartServiceImplementation()
        keychainSevice = KeychainServiceImplementation(identifier: Bundle.id)
        networkService = NetworkServiceImplementation(keychainService: keychainSevice)
        userDefaultsService = UserDefaultsServiceImplementation(keychainService: keychainSevice)
        locationService = LocationServiceImplementation()
    }
    
}
