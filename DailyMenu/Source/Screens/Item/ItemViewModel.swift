//
//  ItemViewModel.swift
//

import Foundation

//MARK: - View
protocol ItemView: class {

}

//MARK: - ViewModel
protocol ItemViewModel {

var view: ItemView? { get set }

}

//MARK: - Implementation
final class ItemViewModelImplementation: ItemViewModel {

  weak var view: ItemView?

  init() {
  }

}


