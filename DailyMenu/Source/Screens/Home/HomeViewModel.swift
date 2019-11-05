//  Created by Uladzimir Pryhazhanau
//  2019

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


