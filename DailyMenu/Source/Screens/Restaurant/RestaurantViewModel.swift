//
//  RestaurantViewModel.swift
//

import Foundation

//MARK: - View
protocol RestaurantView: class {

}

//MARK: - ViewModel
protocol RestaurantViewModel {

var view: RestaurantView? { get set }

}

//MARK: - Implementation
final class RestaurantViewModelImplementation: RestaurantViewModel {

  weak var view: RestaurantView?

  init() {
  }

}


