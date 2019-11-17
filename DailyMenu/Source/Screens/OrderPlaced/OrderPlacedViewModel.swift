//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

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


