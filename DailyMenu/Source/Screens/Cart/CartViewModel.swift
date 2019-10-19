//
//  CartViewModel.swift
//  Daily Menu
//

import Foundation

//MARK: - View
protocol CartView: class {

}

//MARK: - ViewModel
protocol CartViewModel {

var view: CartView? { get set }

}

//MARK: - Implementation
final class CartViewModelImplementation: CartViewModel {

  weak var view: CartView?

  init() {
  }

}


