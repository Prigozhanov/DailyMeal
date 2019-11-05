//  Created by Vladimir on 11/5/19.
//  Copyright © 2019 epam. All rights reserved.
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


