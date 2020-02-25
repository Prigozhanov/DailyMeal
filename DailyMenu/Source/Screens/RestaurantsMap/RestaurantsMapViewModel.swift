//
//  RestaurantsMapViewModel.swift
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Services
import Networking

//MARK: - View
protocol RestaurantsMapView: class {
    func reloadScreen()
}

//MARK: - ViewModel
protocol RestaurantsMapViewModel {
    
    var view: RestaurantsMapView? { get set }
    
    var isFilterApplied: Bool { get }
    var filterViewModel: RestaurantFilterViewModel? { get set }
    
    var restaurants: [Restaurant] { get }
    var filteredRestaurants: [Restaurant] { get }
    
    var categories: [Int: [ProductCategory]] { get }
    var products: [Int: [Product]] { get }
    
    
    func loadRestaurants()
    
}

//MARK: - Implementation
final class RestaurantsMapViewModelImplementation: RestaurantsMapViewModel {
    
    weak var view: RestaurantsMapView?
    
    var filterViewModel: RestaurantFilterViewModel?
    
    let context: AppContext
    let userDefaultsService: UserDefaultsService
    
    var restaurants: [Restaurant]
    
    var isFilterApplied: Bool {
        return filterViewModel != nil
    }
    
    var filteredRestaurants: [Restaurant] {
        guard let filter = filterViewModel else {
            return []
        }
        
        let categoriesFilteredRestaurants = restaurants.filter {
            convertedCategories[$0.id]?.isSuperset(of: filter.filterCategories) ?? false
        }
        
        let priceFilteredRestaurants = categoriesFilteredRestaurants.filter {
            let allPricesArray = products[$0.id]?.compactMap({
                guard let price = Double($0.price)?.intValue else {
                    return nil
                }
                return price > 0 ? price : nil
            }) ?? [] as Array<Int>

            let priceFilterRange = filter.priceRange.lowerValue...filter.priceRange.upperValue
            return allPricesArray.contains { priceFilterRange.contains($0) }
        }
        
        let ratingFilteredRestaurants = priceFilteredRestaurants.filter {
            guard let rate = Double($0.rate) else {
                return false
            }
            return Int($0.distance) < filter.radius &&
                rate > filter.ratingRagne.lowerValue &&
                rate < filter.ratingRagne.upperValue
        }
        
        guard !filter.restaurantName.isEmpty else {
            return ratingFilteredRestaurants
        }
        
        return ratingFilteredRestaurants.filter {
            $0.chainLabel.containsCaseIgnoring(filter.restaurantName)
        }
    }
    
    var categories: [Int : [ProductCategory]] = [:]
    var convertedCategories: [Int: Set<FoodCategory>] {
        return categories.compactMapValues({ Set($0.compactMap({ FoodCategory.fromProductCategory(category: $0) })) })
    }
    
    var products: [Int : [Product]] = [:]
    
    init() {
        context = AppDelegate.shared.context
        userDefaultsService = context.userDefaultsService
        restaurants = []
    }
    
    func loadRestaurants() {
        guard let areaId = userDefaultsService.getValueForKey(key: .areaId) as? Int,
            let addressId = userDefaultsService.getValueForKey(key: .addressesId) as? Int else {
                return
        }
        let req = context.networkService.requestFactory.menu(cityId: areaId, addressId: addressId)
        context.networkService.send(request: req) { [weak self] result, _ in
            LoadingIndicator.hide()
            switch result {
            case let .success(response):
                self?.restaurants = response.restaurants.filter({ $0.type == .restaurant })
                self?.view?.reloadScreen()
                self?.loadRestaurantsDetails()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func loadRestaurantsDetails() {
        let group = DispatchGroup()
        restaurants.forEach { rest in
            group.enter()
            loadCategory(restId: rest.id) {
                group.leave()
            }
            group.enter()
            loadMenu(restId: rest.id) {
                group.leave()
            }
        }
        
        group.notify(queue: .global(qos: .background)) {
            
        }
    }
    
    private func loadCategory(restId: Int, completion: @escaping VoidClosure) {
        let req = context.networkService.requestFactory.restaurantCategories(id: restId)
        
        context.networkService.send(request: req) { [weak self] (result, _) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.categories[restId] = response.data
            case let .failure(error):
                logDebug(message: error.localizedDescription)
                
            }
        }
    }
    
    private func loadMenu(restId: Int,completion: @escaping VoidClosure) {
        let req = context.networkService.requestFactory.restaurantMenu(id: restId)
        context.networkService.send(request: req, completion: { [weak self] result, _ in
            switch result {
            case let .success(response):
                guard let products = response.data else {
                    return
                }
                self?.products[restId] = products
            case let .failure(error):
                logDebug(message: error.localizedDescription)
            }
            completion()
        })
    }
}
