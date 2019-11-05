//  Created by Uladzimir Pryhazhanau
//  2019


import Foundation

//MARK: - View
protocol OrderPlacedView: class {

}

//MARK: - ViewModel
protocol OrderPlacedViewModel {

var view: OrderPlacedView? { get set }

}

//MARK: - Implementation
final class OrderPlacedViewModelImplementation: OrderPlacedViewModel {

  weak var view: OrderPlacedView?

  init() {
  }

}


