//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

final class GreetingViewController: UIViewController {
    
    private var viewModel: GreetingViewModel
    
    lazy var signInButton = UIButton.makeActionButton("Sign in") { [weak self] button in
        button.tapAnimation()
        self?.viewModel.performLogin()
    }
    
    lazy var signUpRow: UIView = {
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
    
    lazy var skipButton = UIButton.makeCustomButton(title: "Skip >", titleColor: Colors.gray.color, font: FontFamily.light) { [weak self] _ in
        self?.dismiss(animated: true)
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
        
        let fieldsStack = UIStackView.makeVerticalStack()
        view.addSubview(fieldsStack)
        fieldsStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset * 2)
            $0.height.equalTo(100)
        }
        fieldsStack.alignment = .fill
        fieldsStack.spacing = 40
        fieldsStack.addArrangedSubview(UITextField.makeCommonTextField("+1"))
        fieldsStack.addArrangedSubview(UITextField.makeCommonTextField("Password"))
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints {
            $0.top.equalTo(fieldsStack.snp.bottom).offset(40)
            $0.center.equalTo(view)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset * 2)
            $0.height.equalTo(50)
        }
        
        view.addSubview(signUpRow)
        signUpRow.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(Layout.largeMargin)
            $0.centerX.equalTo(view)
        }
        
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints {
            $0.bottom.equalTo(view.snp_bottomMargin).offset(-20)
            $0.centerX.equalTo(view)
        }
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Style.addBlueGradient(signInButton)
    }
    
}

//MARK: -  GreetingView
extension GreetingViewController: GreetingView {
    func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: -  Private
private extension GreetingViewController {
    
}


