//  Created by Uladzimir Pryhazhanau
//  2019


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


