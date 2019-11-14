//
// Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol CheckoutView: class {

}

//MARK: - ViewModel
protocol CheckoutViewModel {

var view: CheckoutView? { get set }

}

//MARK: - Implementation
final class CheckoutViewModelImplementation: CheckoutViewModel {

  weak var view: CheckoutView?

  init() {
  }

}


