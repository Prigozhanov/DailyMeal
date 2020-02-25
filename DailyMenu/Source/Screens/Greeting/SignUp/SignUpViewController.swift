//
//  Created by Vladimir on 2/6/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private var viewModel: SignUpViewModel
    
    private lazy var contentView = SignUpContentView(
        item: SignUpContentView.Item(
            onSignUpAction: { [weak self] email, password, phone in
                self?.viewModel.email = email
                self?.viewModel.password = password
                self?.viewModel.phone = phone
                self?.viewModel.signUp()
            }
        )
    )
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        viewModel.view = self
        
        view.backgroundColor = Colors.commonBackground.color
        
        let titleLabel = UILabel.makeText("Sign up")
        titleLabel.font = FontFamily.Poppins.medium.font(size: 16)
        
        view.addSubviews([titleLabel, contentView])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(70)
            $0.centerX.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.setupGradient()
    }
    
}

//MARK: -  SignUpView
extension SignUpViewController: SignUpView {
    
    func onSuccessAction() {
        let vc = PhoneVerificationViewController(
            viewModel: PhoneVerificationViewModelImplementation(phone: viewModel.phone)
        )
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func onErrorAction(message: String?) {
        contentView.onErrorAction(errorMessage: message)
    }
}

//MARK: -  Private
private extension SignUpViewController {
    
}


