//
//  RestaurantsMapViewModel.swift
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Services
import Networking

//MARK: - View
protocol RestaurantsMapView: class {
    func addAnnotations()
}

//MARK: - ViewModel
protocol RestaurantsMapViewModel {
    
    var view: RestaurantsMapView? { get set }
    
    var restaurants: [Restaurant] { get }
    
    func loadRestaurants()
    
}

//MARK: - Implementation
final class RestaurantsMapViewModelImplementation: RestaurantsMapViewModel {
    
    weak var view: RestaurantsMapView?
    
    let context: AppContext
    let userDefaultsService: UserDefaultsService
    
    var restaurants: [Restaurant]
    
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
                self?.view?.addAnnotations()
            case let .failure(error):
                print(error)
            }
        }
    }
    
}


