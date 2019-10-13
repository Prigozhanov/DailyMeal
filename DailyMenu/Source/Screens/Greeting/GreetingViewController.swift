//
//  GreetingViewController.swift
//

import UIKit
import SnapKit

final class GreetingViewController: UIViewController {

  private var viewModel: GreetingViewModel

    lazy var signInButton = HugeButton(title: "Sign in") { _ in
        self.show(LoginViewController(viewModel: LoginViewModelImplementation()), sender: nil)
    }
    
    lazy var signUpRow: UIView = {
        let view = UIView()

        let dontHaveAccountLabel = Design.Label.mediumText("Don't have an account?")
        view.addSubview(dontHaveAccountLabel)
        dontHaveAccountLabel.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(view)
        }
        
        let signUpButton = Design.Button.commonButton("Sign up") { _ in
            self.show(SignUpViewController(viewModel: SignUpViewModelImplementation()), sender: nil)
        }
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalTo(view)
            make.leading.equalTo(dontHaveAccountLabel.snp.trailing).offset(Design.Layout.commonMargin)
        }
        return view
    }()
    
    lazy var skipButton = Design.Button.grayButton("Skip >") { _ in
        self.dismiss(animated: true) {
        }
    }
    
  init(viewModel: GreetingViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
    
    view.backgroundColor = .white
    
    view.addSubview(signInButton)
    signInButton.snp.makeConstraints { make in
        make.center.equalTo(self.view)
    }
    
    view.addSubview(signUpRow)
    signUpRow.snp.makeConstraints { (make) in
        make.top.equalTo(signInButton.snp.bottom).offset(Design.Layout.largeMargin)
        make.centerX.equalTo(self.view)
    }
    
    view.addSubview(skipButton)
    skipButton.snp.makeConstraints { (make) in
        make.bottom.equalTo(self.view.snp_bottomMargin).offset(-20)
        make.centerX.equalTo(self.view)
    }
  }
}

//MARK: -  GreetingView
extension GreetingViewController: GreetingView {

}

//MARK: -  Private
private extension GreetingViewController {

}


