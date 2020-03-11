//
//  Created by Vladimir on 2/25/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import Extensions

class SignUpContentView: UIView {
    
    struct Item {
        let onSignUpAction: (String, String, String) -> Void
        var phone = ""
        var email = ""
        var password = ""
        
        init(onSignUpAction: @escaping (String, String, String) -> Void) {
            self.onSignUpAction = onSignUpAction
        }
    }
    
    private var item: Item
    
    private lazy var emailTextField: TextField = {
        let field = TextField(
			placeholder: Localizable.Greeting.email,
            shouldShowClearButton: true,
            shouldChangeCharacters: { [weak self] (textField, _, string) -> Bool in
                self?.item.email = textField.text?.appending(string) ?? ""
                return true
            },
            shouldReturn: { textField -> Bool in
                textField.resignFirstResponder()
                return true
        })
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        return field
    }()
    
    private lazy var passwordTextField: TextField = {
        let field = TextField(
			placeholder: Localizable.Greeting.password,
            shouldShowClearButton: true,
            shouldChangeCharacters: { [weak self] (textField, _, string) -> Bool in
                self?.item.password = textField.text?.appending(string) ?? ""
                return true
            },
            shouldReturn: { textField -> Bool in
                textField.resignFirstResponder()
                return true
        })
        field.isSecureTextEntry = true
        return field
    }()
    
    private lazy var phoneTextField: TextField = {
        let field = TextField(
            placeholder: "+375",
            shouldShowClearButton: true,
            shouldChangeCharacters: { [weak self] (textField, _, string) -> Bool in
                if string.isEmpty {
                    return true
                }
                let text = textField.text?.replacingOccurrences(of: "+", with: "")
                if let formattedText = textField.text,
                    Formatter.PhoneNumber.shouldChange(string: text?.appending(string), maxCharacters: 15) {
                    self?.item.phone = text?.appending(string) ?? ""
                    textField.text = Formatter.PhoneNumber.formattedString(text?.appending(string)) ?? ""
                    return false
                }
                return false
            }, shouldReturn: { textField -> Bool in
                textField.resignFirstResponder()
                return true
        })
        field.keyboardType = .phonePad
        return field
    }()
    
	private lazy var signUpButton = ActionButton(Localizable.Greeting.signup) { [unowned self] _ in
        self.item.onSignUpAction(self.item.email, self.item.password, "+\(self.item.phone)")
    }
    
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel.makeSmallText()
        label.textColor = Colors.red.color
        label.alpha = 0
        label.textAlignment = .center
		label.numberOfLines = 2
        return label
    }()
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        let cardView = CardView(shadowSize: .large, customInsets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
		let titleLabel = UILabel.makeText(Localizable.Signup.createAccount)
        titleLabel.font = FontFamily.Avenir.medium.font(size: 16)
        titleLabel.textAlignment = .center
        let subtitleLabel = UILabel.makeText(Localizable.Signup.willSendCode)
        subtitleLabel.font = FontFamily.Avenir.book.font(size: 12)
        subtitleLabel.textColor = Colors.gray.color
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 3
        
        addSubview(cardView)
        cardView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        cardView.contentView.addSubviews([
            titleLabel,
            subtitleLabel,
            errorMessageLabel,
            emailTextField,
            passwordTextField,
            phoneTextField,
            signUpButton])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.largeMargin)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        errorMessageLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(25)
			$0.leading.trailing.greaterThanOrEqualToSuperview().inset(Layout.commonInset)
            $0.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(errorMessageLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(Layout.largeMargin)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
        }
        
        phoneTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(Layout.largeMargin)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(phoneTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func onErrorAction(errorMessage: String?) {
        shakeAnimation()
        passwordTextField.text = ""
        phoneTextField.text = ""
        
        errorMessageLabel.text = errorMessage ?? ""
        errorMessageLabel.temporaryAppear(seconds: 5)
        
    }
    
}
