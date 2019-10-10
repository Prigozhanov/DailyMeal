//
//  LoginViewController.swift
//


import Foundation
import UIKit

final class LoginViewController: UIViewController {

  private var viewModel: LoginViewModel

  init(viewModel: LoginViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }
}

//MARK: -  LoginView
extension LoginViewController: LoginView {

}

//MARK: -  Private
private extension LoginViewController {

}


