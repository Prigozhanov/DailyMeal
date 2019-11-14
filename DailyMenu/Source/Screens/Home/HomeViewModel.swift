//
// Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol HomeView: class {

}

//MARK: - ViewModel
protocol HomeViewModel {

var view: HomeView? { get set }

}

//MARK: - Implementation
final class HomeViewModelImplementation: HomeViewModel {

  weak var view: HomeView?

  init() {
  }

}


