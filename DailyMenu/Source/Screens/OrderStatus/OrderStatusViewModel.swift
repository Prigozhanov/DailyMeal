//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

// MARK: - View
protocol OrderStatusView: class {

}

// MARK: - ViewModel
protocol OrderStatusViewModel {

var view: OrderStatusView? { get set }

}

// MARK: - Implementation
final class OrderStatusViewModelImplementation: OrderStatusViewModel {

  weak var view: OrderStatusView?

  init() {
  }

}
