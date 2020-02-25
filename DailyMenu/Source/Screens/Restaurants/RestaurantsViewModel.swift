//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking
import Services

// MARK: - View
protocol RestaurantsView: class {
    func reloadScreen()
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

// MARK: - ViewModel
protocol RestaurantsViewModel {
    
    var view: RestaurantsView? { get set }
    
    var userName: String { get }
    
    var restaurants: [Restaurant] { get }
    
    var categories: [Int: [ProductCategory]] { get set }
    
    var restaurantsChain: [Restaurant] { get }
    var pagedRestaurants: [Restaurant] { get }
    var filteredRestaurants: [Restaurant] { get }
    
    var filterDidSelected: Bool { get set }
    
    var isFiltering: Bool { get }
    
    var searchFilter: String { get set }
    var categoryFilter: FoodCategory? { get set }
    
    func showMoreRestaurants()
    
    func getRestaurantsFilteredByCategory(_ category: FoodCategory) -> [Restaurant]
    
    func loadRestaurants()
    func loadCategory(restId: Int, onCompletion: @escaping (Result<SingleKeyResponseWrapper<[ProductCategory]>, NetworkClient.Error>) -> Void)
    
}

// MARK: - Implementation
final class RestaurantsViewModelImplementation: RestaurantsViewModel {
    
    let context: AppContext
    let userDefaultsService: UserDefaultsService
    
    weak var view: RestaurantsView?
    
    private let pageSize = 10
    private var pageNumber = 1
    
    var restaurants: [Restaurant] = []
    
    var categories: [Int: [ProductCategory]] = [:]
    
    var isFiltering: Bool {
        return !searchFilter.isEmpty || categoryFilter != nil
    }
    
    var searchFilter: String = "" {
        didSet {
            view?.reloadScreen()
        }
    }
    
    var categoryFilter: FoodCategory?
    
    var userName: String {
        userDefaultsService.getValueForKey(key: .name) as? String ?? ""
    }
    
    var restaurantsChain: [Restaurant] {
        var restChain: [Restaurant] = []
        restaurants.forEach { (rest) in
            if !restChain.contains(where: { rest.chainID == $0.chainID }) {
                restChain.append(rest)
            }
        }
        return restChain
    }
    
    var pagedRestaurants: [Restaurant] {
        var sizeToBeLoaded = pageSize * pageNumber
        if sizeToBeLoaded > restaurantsChain.count {
            sizeToBeLoaded = restaurantsChain.count
        }
        return Array(restaurantsChain[0 ..< sizeToBeLoaded])
    }
    
    var filteredRestaurants: [Restaurant] {
        let restaurants = restaurantsChain.filter({
            
            $0.chainLabel.containsCaseIgnoring(searchFilter)
        })
        var sizeToBeLoaded = pageSize * pageNumber
        if sizeToBeLoaded > restaurants.count {
            sizeToBeLoaded = restaurants.count
        }
        return Array(restaurants[0 ..< sizeToBeLoaded])
    }
    
    var filterDidSelected: Bool = false
    
    var foodCategory: FoodCategory?
    
    init() {
        context = AppDelegate.shared.context
        userDefaultsService = context.userDefaultsService
    }
    
    func getRestaurantsFilteredByCategory(_ category: FoodCategory) -> [Restaurant] {
        restaurantsChain.filter({
            let restId = $0.id
            if categories[restId]?.contains(where: { ($0.label?.containsCaseIgnoring(category.rawValue) ?? false) }) ?? false {
                return true
            }
            return false
        })
    }
    
    func showMoreRestaurants() {
        if pageSize * pageNumber < restaurantsChain.count {
            pageNumber += 1
            view?.reloadScreen()
        }
    }
    
    func loadRestaurants() {
        guard let areaId = userDefaultsService.getValueForKey(key: .areaId) as? Int,
            let addressId = userDefaultsService.getValueForKey(key: .addressesId) as? Int else {
                return
        }
        
        let req = context.networkService.requestFactory.menu(cityId: areaId, addressId: addressId)
        view?.showLoadingIndicator()
        context.networkService.send(request: req) { [weak self] result, _ in
            switch result {
            case let .success(response):
                self?.restaurants = response.restaurants.filter({ $0.type == .restaurant })
                let group = DispatchGroup()
                self?.restaurants.forEach({ rest in
                    group.enter()
                    self?.loadCategory(restId: rest.id, onCompletion: { [weak self] result in
                        switch result {
                        case let .success(response):
                            self?.categories[rest.id] = response.data
                        case let .failure(error):
                            logDebug(message: error.localizedDescription)
                        }
                        group.leave()
                    })
                })
                group.notify(queue: .main) { [weak self] in
                    self?.view?.reloadScreen()
                    self?.view?.hideLoadingIndicator()
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func loadCategory(restId: Int, onCompletion: @escaping (Result<SingleKeyResponseWrapper<[ProductCategory]>, NetworkClient.Error>) -> Void) {
        let req = context.networkService.requestFactory.restaurantCategories(id: restId)
        context.networkService.send(request: req) { result, _ in
            onCompletion(result)
        }
    }
    
}
