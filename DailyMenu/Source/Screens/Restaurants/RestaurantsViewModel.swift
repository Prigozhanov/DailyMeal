//
//  RestaurantsViewModel.swift
//  Daily Menu
//


import Foundation

//MARK: - View
protocol RestaurantsView: class {
  
}

//MARK: - ViewModel
protocol RestaurantsViewModel {
  
  var view: RestaurantsView? { get set }
  
  var restaurants: [Restaurant] { get }
}

//MARK: - Implementation
final class RestaurantsViewModelImplementation: RestaurantsViewModel {
  
  weak var view: RestaurantsView?
  
  var restaurants: [Restaurant] = []
  
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


