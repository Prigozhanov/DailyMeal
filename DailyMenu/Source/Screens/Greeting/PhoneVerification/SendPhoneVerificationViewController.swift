//
//  Created by Vladimir on 2/6/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import Extensions
import Networking

class SendPhoneVerificationViewController: UIViewController {
    
    private var viewModel: PhoneVerificationViewModel
    
    private lazy var contentView = PhoneNumberVerificationContentView(item:
        PhoneNumberVerificationContentView.Item(onSendPhone: { [weak self] phoneNumber in
            LoadingIndicator.show(self)
            self?.viewModel.phoneNumber = phoneNumber
            self?.viewModel.sendPushGeneration(phoneNumber: phoneNumber)
        }))
    
    init(viewModel: PhoneVerificationViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = Colors.commonBackground.color
        
        let titleLabel = UILabel.makeText("Phone verification")
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

extension SendPhoneVerificationViewController: PhoneVerificationView {
    func onSuccessAction() {
        navigationController?.pushViewController(
            EnterValidationCodePhoneVerificationViewController(viewModel: self.viewModel),
            animated: true
        )
    }
    
    func onErrorAction() {
        contentView.onErrorAction()
    }
    
    
    
    
}
