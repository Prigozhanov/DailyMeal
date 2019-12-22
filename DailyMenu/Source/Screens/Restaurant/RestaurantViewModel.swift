//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol RestaurantView: class {
    
}

//MARK: - ViewModel
protocol RestaurantViewModel {
    
    var view: RestaurantView? { get set }
    
    var restaurant: Restaurant { get }
    
}

//MARK: - Implementation
final class RestaurantViewModelImplementation: RestaurantViewModel {
    
    weak var view: RestaurantView?
    
    var restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
}


