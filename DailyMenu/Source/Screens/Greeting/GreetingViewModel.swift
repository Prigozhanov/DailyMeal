//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol GreetingView: class {

}

//MARK: - ViewModel
protocol GreetingViewModel {

var view: GreetingView? { get set }

}

//MARK: - Implementation
final class GreetingViewModelImplementation: GreetingViewModel {

  weak var view: GreetingView?

  init() {
  }

}


