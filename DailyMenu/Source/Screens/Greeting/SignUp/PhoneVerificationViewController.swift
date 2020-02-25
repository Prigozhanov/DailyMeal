//
//  Created by Vladimir on 2/6/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import Networking
import Extensions

class PhoneVerificationViewController: UIViewController {
    
    private var viewModel: PhoneVerificationViewModel
    
    private lazy var contentView = ValidationCodeContentView(item:
        ValidationCodeContentView.Item(
            phone: self.viewModel.phone,
            onSendCode: { [weak self] validationCode in
                self?.viewModel.sendVerifyingCode(validationCode: validationCode)
        })
    )
    
    init(viewModel: PhoneVerificationViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        view.backgroundColor = Colors.commonBackground.color
        
        let titleLabel = UILabel.makeText("Enter verification code")
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
        
        let resendCodeLabel = UIButton.makeCommonButton("Don’t get the code?") { [weak self] _ in
            self?.viewModel.sendPushGeneration()
        }
        resendCodeLabel.setTitleColor(Colors.gray.color, for: .normal)
        resendCodeLabel.titleLabel?.font = FontFamily.Poppins.medium.font(size: 12)
        view.addSubview(resendCodeLabel)
        resendCodeLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        viewModel.sendPushGeneration()
    }
    
}

extension PhoneVerificationViewController: PhoneVerificationView {
    
    func onSuccessAction() {
        if viewModel.phoneVerified {
            self.navigationController?.pushViewController(PhoneVerifiedViewController(), animated: true)
        } else {
            contentView.clear()
        }
    }
    
    func onErrorAction() {
        contentView.onErrorAction()
    }
    
}
