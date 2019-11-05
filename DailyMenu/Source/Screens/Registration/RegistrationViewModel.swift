//  Created by Uladzimir Pryhazhanau
//  2019


import Foundation

//MARK: - View
protocol RegistrationView: class {

}

//MARK: - ViewModel
protocol RegistrationViewModel {

var view: RegistrationView? { get set }

}

//MARK: - Implementation
final class RegistrationViewModelImplementation: RegistrationViewModel {

  weak var view: RegistrationView?

  init() {
  }

}


