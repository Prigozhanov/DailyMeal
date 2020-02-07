//
//  Created by Vladimir on 2/6/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import Networking
import Extensions

class EnterValidationCodePhoneVerificationViewController: UIViewController {
    
    private lazy var contentView = ValidationCodeContentView(item:
        ValidationCodeContentView.Item(
            phoneNumber: self.phoneNumber,
            onSendCode: { [weak self] validationCode in
                self?.sendVerifyingCode(validationCode)
        })
    )
    
    private let phoneNumber: String
    
    private var context: AppContext
    
    init(phoneNumber: String) {
        self.context = AppDelegate.shared.context
        self.phoneNumber = phoneNumber
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    private func sendVerifyingCode(_ string: String) {
        let req = Requests.verifyToken(verifyCode: string)
        
        context.networkService.send(request: req) { [weak self] result in
            switch result {
            case .success:
                self?.navigationController?.pushViewController(PhoneVerifiedViewController(), animated: true)
            case .failure:
                self?.contentView.onErrorAction()
            }
        }
    }
    
}
