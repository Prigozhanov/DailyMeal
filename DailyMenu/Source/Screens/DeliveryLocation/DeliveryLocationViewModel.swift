//
//  DeliveryLocationViewModel.swift
//  Daily Menu
//

import Foundation

//MARK: - View
protocol DeliveryLocationView: class {

}

//MARK: - ViewModel
protocol DeliveryLocationViewModel {

var view: DeliveryLocationView? { get set }

}

//MARK: - Implementation
final class DeliveryLocationViewModelImplementation: DeliveryLocationViewModel {

  weak var view: DeliveryLocationView?

  init() {
  }

}


