//
//  SignUpViewModel.swift
//  Daily Menu
//

import Foundation

//MARK: - View
protocol SignUpView: class {

}

//MARK: - ViewModel
protocol SignUpViewModel {

var view: SignUpView? { get set }

}

//MARK: - Implementation
final class SignUpViewModelImplementation: SignUpViewModel {

  weak var view: SignUpView?

  init() {
  }

}


