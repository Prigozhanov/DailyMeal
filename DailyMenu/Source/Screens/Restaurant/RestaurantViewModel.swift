//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol RestaurantView: class {
    func reloadItems()
}

//MARK: - ViewModel
protocol RestaurantViewModel {
    
    var view: RestaurantView? { get set }
    
    var restaurant: Restaurant { get }
    
    var products: [Product] { get set }
    
    var categories: [Category] { get set }
    
    func getItemsByCategory(_ category: Category) -> [Product]
    func loadInfo()
}

//MARK: - Implementation
final class RestaurantViewModelImplementation: RestaurantViewModel {
    
    weak var view: RestaurantView?
    
    var context = AppDelegate.shared.context
    
    var restaurant: Restaurant
    
    var products: [Product] = []
    
    var categories: [Category] = []
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    func getItemsByCategory(_ category: Category) -> [Product] {
        return products.filter { $0.restaurantMenuCategories == category.restaurantMenuCategories }
    }
    
    func loadInfo() {
        let dispatchGroup = DispatchGroup()
        LoadingIndicator.show()
        dispatchGroup.enter()
        dispatchGroup.enter()
        loadCategories {
            dispatchGroup.leave()
        }
        loadMenu {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {[weak self] in
            LoadingIndicator.hide()
            self?.view?.reloadItems()
        }
    }
    
    func loadMenu(completion: @escaping VoidClosure) {
        let req = Requests.restaurantMenu(id: restaurant.id)
        context?.networkService.send(request: req, completion: { [weak self] result in
            switch result {
            case let .success(response):
                guard let products = response.data else {
                    return
                }
                self?.products = products
            case let .failure(error):
                print(error)
                break // TODO
            }
            completion()
        })
    }
    
    func loadCategories(completion: @escaping VoidClosure) {
        let req = Requests.restaurantCategories(id: restaurant.id)
        context?.networkService.send(request: req, completion: { [weak self] result in
            switch result {
            case let .success(response):
                if let categories = response.data {
                    self?.categories = categories
                } else {
                }
            case let .failure(error):
                print(error)
                break // TODO
            }
            completion()
        })
    }
    
}
