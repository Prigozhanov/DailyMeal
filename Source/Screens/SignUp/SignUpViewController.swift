//
//  SignUpViewController.swift
//

import UIKit

final class SignUpViewController: UIViewController {

  private var viewModel: SignUpViewModel

  init(viewModel: SignUpViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
    
    self.view.backgroundColor = .white
  }
}

//MARK: -  SignUpView
extension SignUpViewController: SignUpView {

}

//MARK: -  Private
private extension SignUpViewController {

}


