//
//  OrderStatusViewModel.swift
//  Daily Menu
//

import Foundation

//MARK: - View
protocol OrderStatusView: class {

}

//MARK: - ViewModel
protocol OrderStatusViewModel {

var view: OrderStatusView? { get set }

}

//MARK: - Implementation
final class OrderStatusViewModelImplementation: OrderStatusViewModel {

  weak var view: OrderStatusView?

  init() {
  }

}


