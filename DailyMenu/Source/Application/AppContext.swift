//
//  Created by Vladimir on 1/13/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import Networking

typealias AppContextProtocol = CartServiceHolder & NetworkServiceHolder

class AppContext: AppContextProtocol {
    
    var networkService: NetworkService
    var cartService: CartService
    
    init() {
        self.cartService = CartServiceImplementation()
        self.networkService = NetworkServiceImplementation()
    }
    
}
