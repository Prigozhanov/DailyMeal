//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import Extensions

final class GreetingViewController: UIViewController {
    
    private var viewModel: GreetingViewModel
    
    private var notificationTokens: [Token] = []
    
    private var signUpViewController: UINavigationController?
    
    private lazy var emailField: TextField = {
        let textField = TextField(
			placeholder: Localizable.Greeting.email,
            image: Images.Icons.envelope.image) { textField -> Bool in
            textField.resignFirstResponder()
            return true
        }
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordField: TextField = {
        let textField = TextField(
			placeholder: Localizable.Greeting.password,
            image: Images.Icons.password.image) { textField -> Bool in
            textField.resignFirstResponder()
            return true
        }
        textField.isSecureTextEntry = true
        return textField
    }()
    
	private lazy var signInButton = ActionButton(Localizable.Greeting.login) { [weak self] button in
        self?.viewModel.email = self?.emailField.text ?? ""
        self?.viewModel.password = self?.passwordField.text ?? ""
        LoadingIndicator.show(self)
        self?.viewModel.performLogin(onSuccess: {
			UINotificationFeedbackGenerator.impact(.success)
            self?.dismiss(animated: true, completion: nil)
        }, onFailure: {
			UINotificationFeedbackGenerator.impact(.error)
            button.shakeAnimation()
            self?.passwordField.text = ""
            self?.showAuthorizationError()
        })
    }
    
    private lazy var signUpRow: UIView = {
        let view = UIView()
        
		let dontHaveAccountLabel = UILabel.makeMediumText(Localizable.Greeting.dontHaveAccount)
        view.addSubview(dontHaveAccountLabel)
        dontHaveAccountLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalTo(view)
        }
        
        let signUpButton = UIButton.makeCustomButton(
			title: Localizable.Greeting.signup,
            titleColor: Colors.blue.color,
            cornerRadius: 5,
            font: FontFamily.semibold
        ) { [weak self] _ in
            self?.signUpViewController = UINavigationController(rootViewController:
                SignUpViewController(viewModel: SignUpViewModelImplementation())
            )
            if let vc = self?.signUpViewController {
                self?.show(vc, sender: nil)
            }
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalTo(view)
            $0.leading.equalTo(dontHaveAccountLabel.snp.trailing).offset(Layout.commonMargin)
        }
        return view
    }()
    
    private lazy var skipButton = UIButton.makeCustomButton(
		title: NSLocalizedString(Localizable.Greeting.skip, comment: ""), // TODO arrow
        titleColor: Colors.gray.color,
        font: FontFamily.light) { [weak self] _ in
            self?.dismiss(animated: true, completion: {
                NotificationCenter.default.post(Notification(name: .userInvalidAddress))
            })
    }
    
    private lazy var authorizationErrorLabel: UILabel = {
		let label = UILabel.makeText(Localizable.Greeting.incorrectCredentials)
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
        
        notificationTokens.append(Token.make(descriptor: .userSignedUpDescriptor, using: { [weak self] _ in
            self?.signUpViewController?.dismiss(animated: true, completion: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
        }))
        
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
    
}

// MARK: - GreetingView
extension GreetingViewController: GreetingView {
    func showAuthorizationError() {
        authorizationErrorLabel.temporaryAppear(seconds: 5)
    }
}

// MARK: - Private
private extension GreetingViewController {
    
}

extension NotificationDescriptor {
    
    static var userSignedUpDescriptor: NotificationDescriptor<Void> {
            return NotificationDescriptor<Void>(name: .userSignedUp) { _ in
        }
    }
    
    static var userInvalidAddress: NotificationDescriptor<Void> {
            return NotificationDescriptor<Void>(name: .userInvalidAddress) { _ in
        }
    }
    
}
