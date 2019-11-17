//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol RestaurantsView: class {
    
}

//MARK: - ViewModel
protocol RestaurantsViewModel {
    
    var view: RestaurantsView? { get set }
    
    var restaurants: [Restaurant] { get }
    
    var filterDidSelected: Bool { get set }
    
    var foodCategory: FoodCategory? { get set }
    
}

//MARK: - Implementation
final class RestaurantsViewModelImplementation: RestaurantsViewModel {
    
    weak var view: RestaurantsView?
    
    var restaurants: [Restaurant] = []
    
    var filterDidSelected: Bool = false
    
    var foodCategory: FoodCategory?
    
    init() {
        let path = Bundle.main.path(forResource: "restaurants", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
            let jsonString = String(data: data, encoding: .utf8)
            restaurants = try JSONDecoder().decode([Restaurant].self, from: jsonString!.data(using: .utf8)!)
        } catch let error {
            print(error)
        }
    }
    
}


