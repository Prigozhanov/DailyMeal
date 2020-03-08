//
//  Created by Vladimir on 2/23/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

typealias RangeValue<T> = (lowerValue: T, upperValue: T)

protocol RestaurantsFilterView {
    
}

protocol RestaurantFilterViewModel {
    
    var radius: Int { get set }
    var priceRange: RangeValue<Int> { get set }
    var filterCategories: [FoodCategory] { get set }
    var ratingRagne: RangeValue<Double> { get set }
    var restaurantName: String { get set }
    
    var onRemoveFilter: VoidClosure { get }
    var onApplyFilter: (RestaurantFilterViewModel) -> Void { get }
    
}

class RestaurantFilterViewModelImplementation: RestaurantFilterViewModel {
    
    var radius: Int = 4
    var priceRange: RangeValue<Int> = (4, 40)
    var filterCategories: [FoodCategory] = []
    var ratingRagne: RangeValue<Double> = (2, 4)
    var restaurantName: String = ""
    
    var onRemoveFilter: VoidClosure
    var onApplyFilter: (RestaurantFilterViewModel) -> Void
    
    init(onRemoveFilter: @escaping VoidClosure, onApplyFilter: @escaping (RestaurantFilterViewModel) -> Void) {
        self.onRemoveFilter = onRemoveFilter
        self.onApplyFilter = onApplyFilter
    }
    
}
