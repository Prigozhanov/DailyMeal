//  Created by Vladimir on 11/5/19.
//  Copyright © 2019 epam. All rights reserved.
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


