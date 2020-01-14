//
//  Created by Vladimir on 1/13/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

class AppContext: CartServiceHolder {
    
    var cartService: CartService
    
    init() {
        self.cartService = CartServiceImplementation()
    }
    
}
