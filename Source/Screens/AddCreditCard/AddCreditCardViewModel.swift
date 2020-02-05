//
//  AddCreditCardViewModel.swift
//

import Foundation

//MARK: - View
protocol AddCreditCardView: class {

}

//MARK: - ViewModel
protocol AddCreditCardViewModel {

var view: AddCreditCardView? { get set }

}

//MARK: - Implementation
final class AddCreditCardViewModelImplementation: AddCreditCardViewModel {

  weak var view: AddCreditCardView?

  init() {
  }

}


