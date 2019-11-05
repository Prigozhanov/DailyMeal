//  Created by Uladzimir Pryhazhanau
//  2019


import Foundation

//MARK: - View
protocol LoginView: class {

}

//MARK: - ViewModel
protocol LoginViewModel {

var view: LoginView? { get set }

}

//MARK: - Implementation
final class LoginViewModelImplementation: LoginViewModel {

  weak var view: LoginView?

  init() {
  }

}


