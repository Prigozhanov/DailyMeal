//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol ItemView: class {
    func reloadTotalLabelView()
}

//MARK: - ViewModel
protocol ItemViewModel {
    
    var view: ItemView? { get set }
    
    var cartService: CartService { get }
    
    var item: CartItem { get }
    
}

//MARK: - Implementation
final class ItemViewModelImplementation: ItemViewModel {
    
    weak var view: ItemView?
    
    var cartService: CartService = AppDelegate.shared.context.cartService
    
    let item: CartItem
    
    init(item: CartItem) {
        self.item = item
    }
    
}


