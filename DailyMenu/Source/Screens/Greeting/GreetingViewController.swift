//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

final class GreetingViewController: UIViewController {
    
    private var viewModel: GreetingViewModel
    
    private lazy var emailField: TextField = {
        let textField = TextField(
            placeholder: "E-mail",
            image: Images.Icons.envelope.image,
            shouldChangeCharacters: { (_, _, _) -> Bool in
                true
        },
            shouldBeginEditing: { (_) -> Bool in
                true
        },
            didBeginEditing: { (_) in
                
        },
            shouldEndEditing: { (_) -> Bool in
                true
        },
            didEndEditing: { (_, _) in
                
        },
            didChangeSelection: { (_) in
                
        },
            shouldClear: { (_) -> Bool in
                true
        }) { (_) -> Bool in
            true
        }
        return textField
    }()
    
    private lazy var passwordField: TextField = {
        let textField = TextField(
            placeholder: "Password",
            image: Images.Icons.password.image,
            shouldChangeCharacters: { (_, _, _) -> Bool in
                true
        },
            shouldBeginEditing: { (_) -> Bool in
                true
        },
            didBeginEditing: { (_) in
                
        },
            shouldEndEditing: { (_) -> Bool in
                true
        },
            didEndEditing: { (_, _) in
                
        },
            didChangeSelection: { (_) in
                
        },
            shouldClear: { (_) -> Bool in
                true
        }) { (_) -> Bool in
            true
        }
        textField.setSecureEntry(true)
        return textField
    }()
    
    private lazy var signInButton = UIButton.makeActionButton("Sign in") { [weak self] button in
        self?.viewModel.email = self?.emailField.text ?? ""
        self?.viewModel.password = self?.passwordField.text ?? ""
        self?.viewModel.performLogin(onSuccess: {
            button.tapAnimation()
            self?.dismiss(animated: true, completion: nil)
        }, onFailure: {
            button.shakeAnimation()
            self?.passwordField.text = ""
            self?.showAuthorizationError()
        })
    }
    
    private lazy var signUpRow: UIView = {
        let view = UIView()
        
        let dontHaveAccountLabel = UILabel.makeMediumText("Don't have an account?")
        view.addSubview(dontHaveAccountLabel)
        dontHaveAccountLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalTo(view)
        }
        
        
        let signUpButton = UIButton.makeCustomButton(
            title: "Sign up",
            titleColor: Colors.blue.color,
            cornerRadius: 5,
            font: FontFamily.semibold
        ) { [weak self] button in
            self?.show(SignUpViewController(viewModel: SignUpViewModelImplementation()), sender: nil)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalTo(view)
            $0.leading.equalTo(dontHaveAccountLabel.snp.trailing).offset(Layout.commonMargin)
        }
        return view
    }()
    
    private lazy var skipButton = UIButton.makeCustomButton(title: "Skip >", titleColor: Colors.gray.color, font: FontFamily.light) { [weak self] _ in
        self?.dismiss(animated: true)
    }
    
    private lazy var authorizationErrorLabel: UILabel = {
        let label = UILabel.makeText("Incorrect email or password")
        label.textColor = Colors.red.color
        label.isHidden = true
        return label
    }()
    
    init(viewModel: GreetingViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        view.backgroundColor = .white
        
        emailField.text = viewModel.email
        
        view.addSubviews([emailField, passwordField, signInButton, signUpRow, skipButton, authorizationErrorLabel])
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(200)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset * 2)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(Layout.largeMargin)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(emailField)
        }
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(emailField)
        }
        
        signUpRow.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(Layout.largeMargin)
            $0.centerX.equalTo(view)
        }
        
        skipButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.centerX.equalTo(view)
        }
        
        authorizationErrorLabel.snp.makeConstraints {
            $0.bottom.equalTo(emailField.snp.top).inset(-20)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Style.addBlueGradient(signInButton)
    }
    
}

//MARK: -  GreetingView
extension GreetingViewController: GreetingView {
    func showAuthorizationError() {
        authorizationErrorLabel.isHidden = false
    }
}

//MARK: -  Private
private extension GreetingViewController {
    
}


