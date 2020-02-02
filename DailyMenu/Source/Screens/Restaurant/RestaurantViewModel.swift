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
    
    var items: [CartItem] { get }
    
    var categories: [Category] { get }
    
    func getItemsByCategory(_ category: Category) -> [CartItem]
    func loadMenu()
    func loadCategories()
}

//MARK: - Implementation
final class RestaurantViewModelImplementation: RestaurantViewModel {
    
    weak var view: RestaurantView?
    
    var context = AppDelegate.shared.context
    
    var restaurant: Restaurant
    
    var items: [CartItem] {
        guard let products = products else {
            return []
        }
        return products.map {
            if let item = CartItem.fromProduct($0) {
                return item
            }
            return .empty
        }
    }
    
    var products: [Product]?
    
    var categories: [Category] = []
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    func getItemsByCategory(_ category: Category) -> [CartItem] {
        return items.filter { $0.categoryId == category.restaurantMenuCategories }
    }
    
    func loadMenu() {
        guard let id = restaurant.id else {
            return
        }
        let req = Requests.restaurantMenu(id: id)
        LoadingIndicator.show()
        context?.networkService.send(request: req, comletion: { [weak self] result in
            LoadingIndicator.hide()
            switch result {
            case let .success(response):
                guard let products = response.data else {
                    return
                }
                self?.products = products
                self?.loadCategories()
            case let .failure(error):
                print(error.localizedDescription)
                break // TODO
            }
        })
    }
    
    func loadCategories() {
        guard let id = restaurant.id else {
            return
        }
        let req = Requests.restaurantCategories(id: id)
        LoadingIndicator.show()
        context?.networkService.send(request: req, comletion: { [weak self] result in
            LoadingIndicator.hide()
            switch result {
            case let .success(response):
                if let categories = response.data {
                    self?.categories = categories
                }
                self?.view?.reloadItems()
            case let .failure(error):
                print(error.localizedDescription)
                break // TODO
            }
        })
    }
    
}


