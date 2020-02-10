//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking
import Services

//MARK: - View
protocol RestaurantsView: class {
    func reloadScreen()
    func showLoadingIndicator()
}

//MARK: - ViewModel
protocol RestaurantsViewModel {
    
    var view: RestaurantsView? { get set }
    
    var searchFilter: String { get set }
    
    var restaurants: [Restaurant] { get }
    
    var restaurantsChain: [Restaurant] { get }
    var pagedRestaurants: [Restaurant] { get }
    var filteredRestaurants: [Restaurant] { get }
    
    var filterDidSelected: Bool { get set }
    
    var foodCategory: FoodCategory? { get set }
    
    var isFiltering: Bool { get }
    
    func showMoreRestaurants()
    
    func loadRestaurants()
    
}

//MARK: - Implementation
final class RestaurantsViewModelImplementation: RestaurantsViewModel {
    
    let context: AppContext
    let userDefaultsService: UserDefaultsService
    
    weak var view: RestaurantsView?
    
    private let pageSize = 10
    private var pageNumber = 1
    
    var restaurants: [Restaurant] = []
    
    var isFiltering: Bool {
        return !searchFilter.isEmpty
    }
    
    var searchFilter: String = "" {
        didSet {
            view?.reloadScreen()
        }
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
        context.networkService.send(request: req) { [weak self] (result) in
            LoadingIndicator.hide()
            switch result {
            case let .success(response):
                self?.restaurants = response.restaurants
                self?.view?.reloadScreen()
            case let .failure(error):
                print(error)
            }
        }
    }
    
}


