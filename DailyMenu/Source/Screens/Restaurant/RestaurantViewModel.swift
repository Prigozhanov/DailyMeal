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
    
    func loadMenu()
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
            guard let id = $0.id, let name = $0.label,let price = Formatter.Currency.fromString($0.price) else { return .empty }
            return CartItem(id: id, name: name, price: price, description: $0.content, imageURL: $0.src, options: [])
            
        }
    }
    
    var products: [Product]?
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
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
                self?.view?.reloadItems()
            case .failure:
                break // TODO
            }
        })
    }
    
}


