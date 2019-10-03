//
//  RestaurantsViewModel.swift
//

import Foundation

//MARK: - View
protocol RestaurantsView: class {

}

//MARK: - ViewModel
protocol RestaurantsViewModel {

var view: RestaurantsView? { get set }

}

//MARK: - Implementation
final class RestaurantsViewModelImplementation: RestaurantsViewModel {

  weak var view: RestaurantsView?

  init() {
  }

}


