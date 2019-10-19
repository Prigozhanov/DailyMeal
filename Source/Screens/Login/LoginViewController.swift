//
//  LoginViewController.swift
//  Daily Menu
//

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
    
    self.view.backgroundColor = .white
    
    let stack = UIStackView.makeVerticalStack()
    view.addSubview(stack)
    stack.snp.makeConstraints { (make) in
        make.center.equalTo(self.view)
        make.leading.equalTo(self.view).offset(50)
        make.trailing.equalTo(self.view).offset(-50)
        make.height.equalTo(150)
    }
    stack.alignment = .fill
    stack.spacing = 40
    stack.addArrangedSubview(UIInputView.makeCommonInput("+1"))
    stack.addArrangedSubview(UIInputView.makeCommonInput("Password"))
  }
}

//MARK: -  LoginView
extension LoginViewController: LoginView {

}

//MARK: -  Private
private extension LoginViewController {

}


